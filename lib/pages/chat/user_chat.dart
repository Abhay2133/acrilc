import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserChat extends StatelessWidget {
  final String userId;

  const UserChat({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          context.pop();
        }, icon: Icon(Icons.arrow_back_ios_rounded)),
      ),

      body: Center(child: Text("TODO"),),
    );
  }
}
