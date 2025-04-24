import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'dart:io';

import 'package:acrilc/constants/colors.dart';
import 'package:acrilc/services/post_service.dart';
import 'package:acrilc/util.dart';
import 'package:acrilc/widgets/buttons.dart';
import 'package:acrilc/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:acrilc/models/post.dart';
import 'package:path_provider/path_provider.dart';

class CreatePostScreen extends StatefulWidget {
  final PostData? postData;
  const CreatePostScreen({super.key, this.postData});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  @override
  void initState() {
    super.initState();

    if (widget.postData == null) return;
    isLoadingImages = true;

    List<String> urls = [];
    for (int i = 0; i < widget.postData!.media!.length; i++) {
      Map<String, dynamic> media = widget.postData!.media![i];
      if (media.containsKey("type") && media['type'] == 'image') {
        urls.add(media['url']);
      }
    }

    _downloadImages(urls);
    _titleController.text = widget.postData?.title ?? "";
    _storyController.text = widget.postData?.story ?? "";
    _sizeController.text = widget.postData?.size ?? "";
    _tags.addAll(widget.postData?.hashTags ?? []);
    _selectedForte = "Digital"; //widget.postData?.forte ?? "";
  }

  void _downloadImages(List<String>? urls) async {
    if (urls == null || urls.isEmpty) {
      setState(() {
        isLoadingImages = false;
        isLoadingImagesFailed = true;
      });
      return;
    }

    setState(() {
      isLoadingImages = true;
      isLoadingImagesFailed = false;
    });

    List<XFile> loadedImage = [];

    try {
      final tempDir = await getTemporaryDirectory();

      for (int i = 0; i < urls.length; i++) {
        final url = urls[i];

        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          Uint8List bytes = response.bodyBytes;

          String filePath = '${tempDir.path}/downloaded_image_$i.jpg';
          File file = File(filePath);
          await file.writeAsBytes(bytes);

          loadedImage.add(XFile(file.path));
        } else {
          print("Failed to download image at $url");
        }
      }

      setState(() {
        _images.addAll(loadedImage);
        isLoadingImages = false;
        isLoadingImagesFailed = false;
      });
    } catch (e) {
      print("Error downloading images: $e");
      setState(() {
        isLoadingImages = false;
        isLoadingImagesFailed = true;
      });
    }
  }

  bool isLoadingImages = false;
  bool isLoadingImagesFailed = false;

  final _formKey = GlobalKey<FormState>();
  final List<XFile> _images = [];
  final picker = ImagePicker();

  String? _selectedCollection = 'None';
  String? _selectedForte;
  final List<String> _tags = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _storyController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();

  bool isLoading = false;

  Future<void> _pickImages() async {
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      // Filter out unsupported file types
      final filteredFiles =
          pickedFiles.where((file) {
            final extension = path.extension(file.path).toLowerCase();
            return ['.jpg', '.jpeg', '.png', '.gif'].contains(extension);
          }).toList();

      // Optionally notify user if some files were skipped
      if (filteredFiles.length != pickedFiles.length) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Only JPG, PNG, and GIF files are allowed. Some files were ignored.',
            ),
          ),
        );
      }
      setState(() {
        _images.addAll(filteredFiles);
      });
    }
  }

  Future<dynamic> _handleSubmit() async {
    if (isLoading == true) return;
    try {
      PostUploadData payload = PostUploadData(
        title: _titleController.text.trim(),
        hashTags: _tags,
        story: _storyController.text.trim(),
        size: _sizeController.text.trim(),
        forte: _selectedForte ?? '',
        files: _images.map((img) => img.path).toList(),
      );
      setState(() {
        isLoading = true;
      });
      PostData post;
      if (widget.postData == null) {
        post = await PostService.create(payload);
      } else {
        post = await PostService.update(widget.postData?.id ?? "", payload);
      }

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Post created successfully")));
        String postId = post.id ?? "";
        if (widget.postData == null) {
          context.replace("/post/$postId");
        } else {
          Navigator.pop(context, post);
        }
      }
    } catch (e) {
      print('Error creating post: $e');
      if (mounted) {
        alert(context, e.toString(), title: "Error Message", copy: true);
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String? _validateRequiredField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? _validateDropdown(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Please select a $fieldName';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context, "null");
          },
        ),
        title: Text(widget.postData == null ? 'Create Post' : 'Update Post'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _imagesUI(context),
            const SizedBox(height: 16),

            // Title
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Post Title'),
              validator: (value) => _validateRequiredField(value, "Title"),
            ),
            const SizedBox(height: 12),

            // Story
            TextFormField(
              controller: _storyController,
              maxLines: 4,
              decoration: const InputDecoration(labelText: 'Post Story'),
              validator: (value) => _validateRequiredField(value, "Story"),
            ),
            const SizedBox(height: 12),

            // Size
            TextFormField(
              controller: _sizeController,
              decoration: const InputDecoration(labelText: 'Size'),
              validator: (value) => _validateRequiredField(value, "Size"),
            ),
            const SizedBox(height: 12),

            // Collection Dropdown (Optional)
            DropdownButtonFormField<String>(
              value: _selectedCollection,
              items:
                  ['None', 'Abstract', 'Modern', 'Vintage']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
              onChanged: (val) => setState(() => _selectedCollection = val),
              decoration: const InputDecoration(labelText: 'Collection'),
              // Optional validator (uncomment to make required):
              validator: (value) => _validateDropdown(value, "Collection"),
            ),
            const SizedBox(height: 12),

            // Type Dropdown (Required)
            DropdownButtonFormField<String>(
              value: _selectedForte,
              items:
                  ['Painting', 'Digital', 'Sketch']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
              onChanged: (val) => setState(() => _selectedForte = val),
              decoration: const InputDecoration(labelText: 'Type'),
              validator: (value) => _validateDropdown(value, "Type"),
            ),
            const SizedBox(height: 12),

            // Tags Input
            TextFormField(
              controller: _tagController,
              decoration: InputDecoration(
                labelText: 'Add Tag',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    final tag = _tagController.text.trim();
                    if (tag.isNotEmpty && !_tags.contains(tag)) {
                      setState(() {
                        _tags.add(tag);
                        _tagController.clear();
                      });
                    }
                  },
                ),
              ),
              onFieldSubmitted: (_) {
                final tag = _tagController.text.trim();
                if (tag.isNotEmpty && !_tags.contains(tag)) {
                  setState(() {
                    _tags.add(tag);
                    _tagController.clear();
                  });
                }
              },
            ),
            const SizedBox(height: 8),
            _tagsUI(context),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Button(
          onPressed: () {
            if (_images.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please add at least one image')),
              );
              return;
            }

            if (_formKey.currentState?.validate() ?? false) {
              _handleSubmit();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Unable to create post!')),
              );
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.postData == null ? 'Create Post' : 'Update Post',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: Colors.white,
                  fontWeightDelta: 500,
                ),
              ),
              isLoading
                  ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Spinner(size: 16),
                  )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tagsUI(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children:
          _tags.map((tag) {
            return Chip(
              label: Text(tag),
              deleteIcon: const Icon(Icons.close),
              onDeleted: () {
                setState(() {
                  _tags.remove(tag);
                });
              },
            );
          }).toList(),
    );
  }

  Widget _imagesUI(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ..._images.asMap().entries.map((entry) {
          final index = entry.key;
          final img = entry.value;
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(img.path),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _images.removeAt(index);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, size: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        }),
        GestureDetector(
          onTap: _pickImages,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColor.secondary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.add_a_photo),
          ),
        ),
      ],
    );
  }
}
