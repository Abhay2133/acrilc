import 'package:acrilc/constants/sample.dart';
import 'package:acrilc/services/log_service.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:share_plus/share_plus.dart';

class PostContainer extends StatelessWidget {
  const PostContainer({super.key});

  @override
  Widget build(BuildContext context) {
    List<PostCardData> data = List.generate(6, (int index) {
      return PostCardData.load(hardcodedPostData[index]);
    });
    // return Placeholder();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:4.0),
      child: ListView.builder(
        itemCount: data.length,
        shrinkWrap:
            true, // 👈 This makes the ListView take only the space it needs
        physics:
            NeverScrollableScrollPhysics(), // 👈 Disable ListView’s scroll because parent scrolls
        itemBuilder: (context, index) {
          PostCardData post = data[index];
          // return Text(post["postID"]);
          return PostCard(
            postId: post.postId,
            profileUrl: post.profileUrl,
            name: post.name,
            createdAt: post.createdAt,
            description: post.description,
            images: post.images,
            likesCount: post.likesCount,
            isLiked: post.isLiked,
            commentsCount: post.commentsCount,
            shareLink: post.shareLink,
          );
        },
      ),
    );
   }
}

class PostCard extends StatefulWidget {
  final String postId;
  final String profileUrl;
  final String name;
  final String createdAt;
  final String description;
  final List<String> images;
  final int likesCount;
  final bool isLiked;
  final int commentsCount;
  final String shareLink;

  const PostCard({
    super.key,
    required this.postId,
    required this.profileUrl,
    required this.name,
    required this.createdAt,
    required this.description,
    required this.images,
    required this.likesCount,
    required this.isLiked,
    required this.commentsCount,
    required this.shareLink,
  });

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late int likes;
  late bool liked;

  @override
  void initState() {
    super.initState();
    likes = widget.likesCount;
    liked = widget.isLiked;
  }

  void toggleLike() {
    setState(() {
      liked = !liked;
      likes += liked ? 1 : -1;
    });
  }

  void _showFullScreenImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: InteractiveViewer(
                boundaryMargin: EdgeInsets.all(0),
                constrained: false,
                child: Image.network(imageUrl, fit: BoxFit.contain),
              ),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _header(context),
            _description(context),
            _gallery(context),
            const SizedBox(height: 10),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Image.network(
            widget.profileUrl,
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.name, style: Theme.of(context).textTheme.bodyLarge),
            Text(
              widget.createdAt,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const Spacer(),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_horiz),
          onSelected: (String value) {
            print("Selected: $value");
          },
          itemBuilder:
              (BuildContext context) => [
                const PopupMenuItem<String>(
                  value: 'Option 1',
                  child: Text('Option 1'),
                ),
                const PopupMenuItem<String>(
                  value: 'Option 2',
                  child: Text('Option 2'),
                ),
                const PopupMenuItem<String>(
                  value: 'Option 3',
                  child: Text('Option 3'),
                ),
              ],
        ),
      ],
    );
  }

  Widget _description(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            widget.description,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget _gallery(BuildContext context) {
    if (widget.images.isEmpty) return const SizedBox.shrink();
    Image image = Image(image: Image.network(widget.images.first).image);
    return SizedBox(
      width: double.infinity,
      // height: 200,
      child: InstaImageViewer(
        child: image,
      ),
    );
    // return ZoomableImageViewer(imageUrl: widget.images.first,);
    // return GestureDetector(
    //   onTap: (){
    //     _showFullScreenImage(context, widget.images.first);
    //   },
    //   child: ClipRRect(
    //     borderRadius: BorderRadius.circular(10),
    //     child: Image.network(
    //       widget.images.first, // Display the first image
    //     ),
    //   ),
    // );
  }

  Widget _footer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _likeButton(),
        _footerButton(Icons.comment_outlined, widget.commentsCount.toString()),
        _footerButton(
          Icons.share_outlined,
          "",
          onPressed: () {
            LogService.debug("Sharing: ${widget.shareLink}");
            Share.share('Check out this awesome app! https://example.com');
          },
        ),
      ],
    );
  }

  Widget _likeButton() {
    return TextButton.icon(
      onPressed: toggleLike,
      icon: Icon(
        liked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
        size: 20,
        color: liked ? Colors.blueAccent : Colors.grey,
      ),
      label: Text(likes.toString(), style: TextStyle(color: Colors.grey[700])),
    );
  }

  Widget _footerButton(IconData icon, String label, {VoidCallback? onPressed}) {
    return TextButton.icon(
      onPressed: onPressed ?? () {},
      icon: Icon(icon, size: 20, color: Colors.grey),
      label: Text(label, style: TextStyle(color: Colors.grey[700])),
    );
  }
}

class PostCardData {
  final String postId;
  final String profileUrl;
  final String name;
  final String createdAt;
  final String description;
  final List<String> images;
  final int likesCount;
  final bool isLiked;
  final int commentsCount;
  final String shareLink;

  PostCardData({
    required this.postId,
    required this.profileUrl,
    required this.name,
    required this.createdAt,
    required this.description,
    required this.images,
    required this.likesCount,
    required this.isLiked,
    required this.commentsCount,
    required this.shareLink,
  });

  static PostCardData load(Map<String, dynamic> json) {
    return PostCardData(
      postId: json['postId'] as String,
      profileUrl: json['profileUrl'] as String,
      name: json['name'] as String,
      createdAt: json['createdAt'] as String,
      description: json['description'] as String,
      images: List<String>.from(json['images']),
      likesCount: json['likesCount'] as int,
      isLiked: json['isLiked'] as bool,
      commentsCount: json['commentsCount'] as int,
      shareLink: json['shareLink'] as String,
    );
  }
}
