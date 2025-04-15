import 'dart:io';

import 'package:acrilc/constants/colors.dart';
import 'package:acrilc/services/post_service.dart';
import 'package:acrilc/util.dart';
import 'package:acrilc/widgets/buttons.dart';
import 'package:acrilc/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:acrilc/models/post.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<XFile> _images = [];
  final picker = ImagePicker();

  String? _selectedCollection = 'None';
  String? _selectedForte;
  final List<String> _tags = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickImages() async {
    final pickedFiles = await picker.pickMultiImage();
    setState(() {
      _images.addAll(pickedFiles);
    });
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _storyController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();

  bool isLoading = false;

  Future<dynamic> _handleSubmit() async {
    if (isLoading == true) return;
    try {
      setState(() {
        isLoading = true;
      });
      final post = await PostService.create(
        PostUploadData(
          title: _titleController.text.trim(),
          hashTags: _tags,
          story: _storyController.text.trim(),
          size: _sizeController.text.trim(),
          forte: _selectedForte ?? '',
          files: _images.map((img) => img.path).toList(),
          // links: [], // no links UI yet
          // mentions: [], // no mentions feature yet
          // location: '', // no location input
          // collectionId: _selectedCollection ?? '',
          // subtitle: '', // no subtitle input, keeping it empty
        ),
      );

      // Optional success feedback
      // print('Post created: ${post.id}');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Post created successfully")));
      }
    } catch (e) {
      print('Error creating post: $e');
      if(mounted)alert(context, e.toString(), title: "Error Message", copy: true);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Create Post'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Images Section
            _imagesUI(context),
            const SizedBox(height: 16),
            // Title
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Post Title'),
            ),
            const SizedBox(height: 12),
            // Story
            TextFormField(
              controller: _storyController,
              maxLines: 4,
              decoration: const InputDecoration(labelText: 'Post Story'),
            ),
            const SizedBox(height: 12),
            // Size
            TextFormField(
              controller: _sizeController,
              decoration: const InputDecoration(labelText: 'Size'),
            ),
            const SizedBox(height: 12),
            // Collection Dropdown
            DropdownButtonFormField<String>(
              value: _selectedCollection,
              items:
                  ['None', 'Abstract', 'Modern', 'Vintage']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
              onChanged: (val) => setState(() => _selectedCollection = val),
              decoration: const InputDecoration(labelText: 'Collection'),
            ),
            const SizedBox(height: 12),
            // Type Dropdown
            DropdownButtonFormField<String>(
              value: _selectedForte,
              items:
                  ['Painting', 'Digital', 'Sketch']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
              onChanged: (val) => setState(() => _selectedForte = val),
              decoration: const InputDecoration(labelText: 'Type'),
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
            if (_formKey.currentState?.validate() ?? false) {
              // handle create post logic here
              _handleSubmit();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Unable to create post !')),
              );
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create Post',
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
