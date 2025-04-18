import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UsersList extends StatelessWidget {

  const UsersList({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          context.pop();
        }, icon: Icon(Icons.arrow_back_ios_rounded)),
        title: Text("New Chat"),
      ),

      body: Center(child: Text("TODO"),),
    );
  }
}
