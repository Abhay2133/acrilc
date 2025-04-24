import 'package:acrilc/services/post_service.dart';
import 'package:acrilc/util.dart';
import 'package:acrilc/widgets/masonary_grid.dart';
import 'package:acrilc/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForteScreen extends StatefulWidget {
  final String forte;
  const ForteScreen({super.key, required this.forte});

  @override
  State<ForteScreen> createState() => _ForteScreenState();
}

class _ForteScreenState extends State<ForteScreen> {
  bool isLoading = true;
  List<Map<String, dynamic>>? postsData;

  void _fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });
      List<Map<String, dynamic>>? data = await PostService.getPostsByForte(
        widget.forte,
      );
      if (data != null) {
        setState(() {
          postsData = data;
        });
      }
    } catch (e) {
      if (mounted) alert(context, e.toString(), title: "Error", copy: true);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.forte} posts"),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: isLoading ? _loader() : _body(context),
    );
  }

  Widget _retry(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Failed to load data'),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _fetchData,
            child: Text('Retry', style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  Widget _loader() {
    return SizedBox(height: 400, child: Center(child: Spinner(size: 40)));
  }

  List<Map<String, dynamic>> normalizePosts() {
    if (postsData == null) return [];
    return postsData!
        .map((post) {
          String? url;
          if (post['media'] is List<dynamic>) {
            List<dynamic> media = post['media'];
            if (media.isNotEmpty) {
              url = media.first['url'];
            }
          }
          return {"target": "/post/${post['_id']}", 'imageURL': url};
        })
        .where((obj) => obj['imageURL'] != null)
        .toList();
  }

  Widget _body(BuildContext context) {
    return postsData == null ? _retry(context): GridUI(data: normalizePosts());
  }
}
