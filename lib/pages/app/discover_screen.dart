import 'package:acrilc/constants/colors.dart';
import 'package:acrilc/services/post_service.dart';
import 'package:acrilc/util.dart';
import 'package:acrilc/widgets/input.dart';
import 'package:acrilc/widgets/masonary_grid.dart';
import 'package:acrilc/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  List<Map<String, dynamic>>? _trendingPosts;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTrendingPost();
  }

  void _fetchTrendingPost() async {
    try {
      List<Map<String, dynamic>>? data = await PostService.getTrendingPosts();
      if (data != null) {
        setState(() {
          _trendingPosts = data;
        });
      }
    } catch (e) {
      if (mounted) alert(context, e.toString(), title: "Error", copy: true);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 20),
        Input(
          searchController: TextEditingController(),
          onSearchChange: (String text) {
            print(text);
          },
        ),
        _heading(context),
        _isLoading ? _loader() : _trendingPostsUI(context),
      ],
    );
  }

  Widget _trendingPostsUI(BuildContext context) {
    return _trendingPosts != null
        ? SizedBox(
          height: MediaQuery.of(context).size.height - 50,
          child: GridUI(
            data:
                _trendingPosts!
                    .map(
                      (post) => ({
                        "imageURL": post['topPostURL'],
                        "target": "/discover/${post['_id']}",
                      }),
                    )
                    .toList(),
          ),
        )
        : _retry(context);
  }

  Widget _retry(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Failed to load Trending Themes'),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _fetchTrendingPost,
            child: Text('Retry', style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  Widget _loader() {
    return SizedBox(height: 400, child: Center(child: Spinner(size: 40)));
  }

  Widget _heading(BuildContext context) {
    TextStyle style = Theme.of(
      context,
    ).textTheme.headlineLarge!.apply(color: AppColor.secondaryText);
    // LogService.debug("DATA");
    // print(AppColor.secondaryText);
    return Container(
      // color: Colors.blueAccent,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text("Trending Themes", style: style),
    );
  }
}
