import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ZoomableImageViewer extends StatelessWidget {
  final String imageUrl;
  final double thumbnailWidth;
  final double thumbnailHeight;

  const ZoomableImageViewer({
    super.key,
    required this.imageUrl,
    this.thumbnailWidth = 200,
    this.thumbnailHeight = 200,
  });

  void _openFullScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImage(imageUrl: imageUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openFullScreen(context),
      child: Image.network(
        imageUrl,
        // width: thumbnailWidth,
        height: thumbnailHeight,
        fit: BoxFit.cover,
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: PhotoView(
            imageProvider: NetworkImage(imageUrl),
            backgroundDecoration: BoxDecoration(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
