import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _jobTitle = '';
  String _location = '';
  String _imageUrl = '';
  String _postText = '';
  String _imagePostUrl = '';

  int _likes = 0;
  int _comments = 0;
  int _shares = 0;

  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Create Post'),
    ),
    body: SingleChildScrollView(
    child: Padding(
    padding: const EdgeInsets.all(16),
    child: Form(
    key: _formKey,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
    TextFormField(
    decoration: InputDecoration(
    labelText: 'Name',
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter your name';
    }
    return null;
    },
    onSaved: (value) {
    _name = value!;
    },
    ),
    SizedBox(height: 16),
    TextFormField(
    decoration: InputDecoration(
    labelText: 'Job Title',
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter your job title';
    }
    return null;
    },
    onSaved: (value) {
    _jobTitle = value!;
    },
    ),
    SizedBox(height: 16),
    TextFormField(
    decoration: InputDecoration(
    labelText: 'Location',
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter your location';
    }
    return null;
    },
    onSaved: (value) {
    _location = value!;
    },
    ),
    SizedBox(height: 16),
    TextFormField(
    decoration: InputDecoration(
    labelText: 'Image URL',
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter an image URL';
    }
    return null;
    },
    onSaved: (value) {
    _imageUrl = value!;
    },
    ),
    SizedBox(height: 16),
    TextFormField(
    maxLines: 5,
    decoration: InputDecoration(
    labelText: 'Post Text',
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter a post text';
    }
    return null;
    },
    onSaved: (value) {
    _postText = value!;
    },
    ),
    SizedBox(height: 16),
    ElevatedButton(
    onPressed: () => _pickImage(ImageSource.gallery),
    child: Text('Select Image'),
    ),
    if (_selectedImage != null) ...[
    SizedBox(height: 16),
    Image.file(
    _selectedImage!,
    height: 200,
    fit: BoxFit.contain,
    ),
    ],
      SizedBox(height: 16),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
// TODO: Implement post creation logic
          }
        },
        child: Text('Create Post'),
      ),
    ],
    ),
    ),
    ),
    ),
    );
  }
}
