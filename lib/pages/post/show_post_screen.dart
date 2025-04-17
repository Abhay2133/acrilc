import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:acrilc/models/post.dart';

class ShowPostScreen extends StatelessWidget {
  final String postId;
  final String backURL;

  const ShowPostScreen({
    super.key,
    required this.postId,
    this.backURL = "/app/home",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Navigator.pop(context);
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(height: 300.0),
            items:
                [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(color: Colors.red),
                        child: Image.asset(
                          "assets/images/wip.png",
                          width: double.infinity,
                        ),
                      );
                    },
                  );
                }).toList(),
          ),
        ],
      ),
    );
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
