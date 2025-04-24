import 'package:acrilc/pages/chat/user_chat.dart';
import 'package:acrilc/widgets/input.dart';
import 'package:flutter/material.dart';

class UsersList extends StatelessWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context) {
    final users = [
      {
        'name': 'Liam Davis',
        'handle': '@liam_davis',
        'message':
            'Hey, I\'m interested in the painting. Can you tell me more about it?',
        'time': '2d',
        'image': 'https://randomuser.me/api/portraits/men/1.jpg',
      },
      {
        'name': 'Ethan Johnson',
        'handle': '@ethan_johnson',
        'message': 'Thanks for the update! Looking forward to receiving it.',
        'time': '5d',
        'image': 'https://randomuser.me/api/portraits/men/2.jpg',
      },
      {
        'name': 'Ava Martinez',
        'handle': '@ava_martinez',
        'message':
            'I like your new piece of art, it would look perfect in my living room.',
        'time': '1w',
        'image': 'https://randomuser.me/api/portraits/women/1.jpg',
      },
      {
        'name': 'Olivia Smith',
        'handle': '@olivia_smith',
        'message': 'Thank you for the kind words. I\'m glad you like it.',
        'time': '1mo',
        'image': 'https://randomuser.me/api/portraits/women/2.jpg',
      },
    ];

    return Scaffold(
      // backgroundColor: const Color(0xFF12100E),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Start new chat",
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Container(
          //     decoration: BoxDecoration(
          //       // color: const Color(0xFF3C3A36),
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     padding: const EdgeInsets.symmetric(horizontal: 12),
          //     child: const TextField(
          //       style: TextStyle(color: Colors.white),
          //       decoration: InputDecoration(
          //         hintText: "Search messages",
          //         hintStyle: TextStyle(color: Colors.white70),
          //         border: InputBorder.none,
          //         icon: Icon(Icons.search, color: Colors.white70),
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Input(
              placeholder: "Search new users",
              onSearchChange: (val) {},
              searchController: TextEditingController(),
            ),
          ),

          // User List
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (_, index) {
                final user = users[index];
                return ListTile(
                  onTap: () {
                    // Navigate to chat screen, passing userId
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserChat(userId: user['handle']!),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(user['image']!),
                  ),
                  title: Text(
                    '${user['name']}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  subtitle: Text(
                    user['handle']!,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(
                    user['time']!,
                    style: Theme.of(context).textTheme.bodyMedium
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}