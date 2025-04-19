import 'package:acrilc/constants/colors.dart';
import 'package:acrilc/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatelessWidget {
  final List<ChatUser> chatUsers = [
    ChatUser(
      name: "Alice",
      lastMessage: "Hey, how's it going?",
      time: DateTime.now().subtract(Duration(minutes: 5)),
      profileUrl: "https://i.pravatar.cc/150?img=1",
    ),
    ChatUser(
      name: "Bob",
      lastMessage: "See you tomorrow!",
      time: DateTime.now().subtract(Duration(hours: 1)),
      profileUrl: "https://i.pravatar.cc/150?img=2",
    ),
    // Add more dummy users if needed
  ];

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Chats")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Input(
              searchController: TextEditingController(),
              onSearchChange: (String val) {},
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chatUsers.length,
              itemBuilder: (context, index) {
                final user = chatUsers[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.profileUrl),
                    radius: 25,
                  ),
                  title: Text(user.name),
                  subtitle: Text(user.lastMessage),
                  trailing: Text(
                    _getTimeAgo(user.time),
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  onTap: () {
                    context.push("/chat/userId");
                    // Handle chat open
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primaryColor,
        onPressed: () {
          // Handle new chat action
          context.push("/chat/new");
        },
        child: Icon(Icons.chat, color: Colors.white),
      ),
    );
  }

  String _getTimeAgo(DateTime time) {
    final duration = DateTime.now().difference(time);
    if (duration.inMinutes < 60) return '${duration.inMinutes} min ago';
    if (duration.inHours < 24) return '${duration.inHours} hrs ago';
    return DateFormat('MMM d').format(time);
  }
}

class ChatUser {
  final String name;
  final String lastMessage;
  final DateTime time;
  final String profileUrl;

  ChatUser({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.profileUrl,
  });
}
