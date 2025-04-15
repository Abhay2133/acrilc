import 'package:flutter/material.dart';
import 'package:acrilc/models/post.dart';

class ShowPostScreen extends StatelessWidget {
  final String postId;

  const ShowPostScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("postId : $postId")));
  }
}

class PostView extends StatelessWidget {
  final PostData post;

  const PostView({super.key, required this.post});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: [Text("HELLO")]));
  }
}
