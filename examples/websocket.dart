import 'dart:io';

import 'package:acrilc/util.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void connectToSocket() async {
  String token = await getAuthToken() ?? "";
  if (token.isEmpty) return print("token missing in local");
  final socket = IO.io(
    'https://joyous-reeta-mohit123-198cb6c8.koyeb.app',
    IO.OptionBuilder().setTransports(['websocket']).setAuth({
      'token': token,
    }).build(),
  );

  socket.connect();
  
  socket.on("welcome", (data) {
    print(data);
  });

  socket.onConnect((_) {
    print('Connected to socket');
  });

  socket.onDisconnect((data) {
    print(data);
    print('Disconnected');
    exit(0);
  });

  // socket.connect();
}

void main() {
  print("connecting web scokets");
  connectToSocket();
}
