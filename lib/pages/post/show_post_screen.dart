import 'package:acrilc/constants/colors.dart';
import 'package:acrilc/models/post.dart';
import 'package:acrilc/services/post_service.dart';
import 'package:acrilc/widgets/buttons.dart';
import 'package:acrilc/widgets/spinner.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class ShowPostScreen extends StatefulWidget {
  final String postId;

  const ShowPostScreen({super.key, required this.postId});

  @override
  State<ShowPostScreen> createState() => _ShowPostScreenState();
}

class _ShowPostScreenState extends State<ShowPostScreen> {
  late Future<PostData?> _postDataFuture;
  late PostData _postData;
  bool _isLoading = true;
  bool _isFailed = false;

  @override
  void initState() {
    super.initState();
    _fetchPost();
  }

  void _fetchPost() async {
    try {
      PostData? data = await PostService.getPost(widget.postId);
      if (data == null) {
        setState(() {
          _isFailed = true;
        });
      } else {
        _postData = data;
      }
    } catch (e) {
      setState(() {
        _isFailed = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onMenuSelected(String value) {
    // You can handle your logic here
    print("Selected: $value");
  }

  @override
  Widget build(BuildContext context) {
    if (_isFailed) {
      return Center(
        child: Column(
          children: [
            Text(
              "Failed to load post",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            ElevatedButton(
              onPressed: _fetchPost,
              child: Text(
                'Retry',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: _onMenuSelected,
            icon: Icon(Icons.more_vert),
            itemBuilder:
                (BuildContext context) => [
                  PopupMenuItem(value: 'secure_it', child: Text('Secure it')),
                  PopupMenuItem(
                    value: 'moodboard',
                    child: Text('Save to Moodboard'),
                  ),
                  PopupMenuItem(
                    value: 'storyboard',
                    child: Text('Move to Storyboard'),
                  ),
                ],
          ),
          SizedBox(width: 8),
        ],
        elevation: 0,
      ),
      body: _isLoading ? Center(child: Spinner(size: 30)) : _postBody(context),
    );
  }

  SingleChildScrollView _postBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              enableInfiniteScroll: false,
              height: 300.0,
              aspectRatio: 16 / 9,
            ),
            items:
                _postData.media
                    ?.where((media) => media['type'] == "image")
                    ?.toList()
                    .map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          // print(i['url']);
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.transparent,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                i['url'],
                                fit: BoxFit.fitWidth,
                                width: double.infinity,
                              ),
                            ),
                          );
                        },
                      );
                    })
                    .toList(),
          ),

          // Positioned(
          //   top: 16,
          //   right: 16,
          //   child: Container(
          //     padding: const EdgeInsets.all(12),
          //     decoration: BoxDecoration(
          //       color: Colors.white.withOpacity(0.9),
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: const [
          //         Text(
          //           "Secure It",
          //           style: TextStyle(fontWeight: FontWeight.bold),
          //         ),
          //         SizedBox(height: 8),
          //         Text("Save to Moodboard"),
          //         Text("Move to Storyboard"),
          //       ],
          //     ),
          //   ),
          // ),
          const SizedBox(height: 24),

          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              _postData.title!,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),

          const SizedBox(height: 12),

          // Forte
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              _postData.forte!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          // size
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
            child: Text(
              _postData.size!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              "Story Behind the Art",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          // Description
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              _postData.story!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Applauds", style: Theme.of(context).textTheme.bodyMedium),
              Text("Comment", style: Theme.of(context).textTheme.bodyMedium),
              Text("Appreciate", style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: const EdgeInsets.symmetric(vertical: 14),
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                // Navigate to marketplace
              },
              child: Text(
                "Move to Marketplace",
                style: Theme.of(context).textTheme.bodyMedium?.apply(
                  color: Colors.white,
                  fontWeightDelta: 3,
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
