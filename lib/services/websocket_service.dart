import 'package:acrilc/constants/env.dart';
import 'package:acrilc/services/log_service.dart';
import 'package:acrilc/util.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();
  factory WebSocketService() => _instance;

  IO.Socket? _socket;
  final String _url = ENV.baseUrl; // No `/socket` here; Socket.IO handles it
  bool _isConnected = false;
  final List<String> _messageBuffer = [];

  Function(String message)? onMessageReceived;
  Function(String event, dynamic data)? onAny;
  WebSocketService._internal();

  Future<void> connect() async {
    String token = await getAuthToken() ?? "";
    if (token.isEmpty) throw Exception("Token is empty");
    if (_isConnected) return LogService.debug("Already Connected");

    _socket = IO.io(
      _url,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .setAuth({'token': token})
          .build(),
    );

    _socket!.onConnect((_) {
      _isConnected = true;
      print('Socket connected');
      _flushMessageBuffer();
    });

    _socket!.onDisconnect((_) {
      _isConnected = false;
      print('Socket disconnected');
    });

    _socket!.onConnectError((data) {
      print('Connection error: $data');
    });

    _socket!.onError((data) {
      print('Socket error: $data');
    });

    _socket!.onAny((event, data) {
      if (onAny != null) {
        onAny!(event, data);
      }
    });

    _socket!.on('message', (data) {
      if (onMessageReceived != null) {
        onMessageReceived!(data.toString());
      }
    });

    _socket!.connect();
  }

  void send(String message) {
    if (_isConnected && _socket != null) {
      _socket!.emit('message', message);
    } else {
      _messageBuffer.add(message);
    }
  }

  void _flushMessageBuffer() {
    for (var msg in _messageBuffer) {
      _socket!.emit('message', msg);
    }
    _messageBuffer.clear();
  }

  void disconnect() {
    _socket?.disconnect();
    _isConnected = false;
  }
}
