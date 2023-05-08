import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _jobTitle = '';
  String _location = '';
  String _postText = '';

  int _likes = 0;
  int _comments = 0;
  int _shares = 0;

  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        print(_selectedImage);
      });
    }
  }

  Future<String?> _uploadImageToFirebaseStorage() async {
    if (_selectedImage == null) {
      return null;
    }

    final storage = firebase_storage.FirebaseStorage.instance;
    final imageRef = storage
        .ref()
        .child('posts/${DateTime.now().millisecondsSinceEpoch}.jpg');
    final metadata =
        firebase_storage.SettableMetadata(contentType: 'image/jpeg');

    final uploadTask = imageRef.putFile(_selectedImage!, metadata);
    final snapshot = await uploadTask
        .whenComplete(() => print('Image uploaded to Firebase Storage'));

    return await snapshot.ref.getDownloadURL();
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
                if (_selectedImage != null)
                  Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,
                  ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => _pickImage(ImageSource.camera),
                      child: Icon(Icons.camera_alt),
                    ),
                    ElevatedButton(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      child: Icon(Icons.photo_library),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final imageUrl = await _uploadImageToFirebaseStorage();

                      FirebaseFirestore.instance.collection('posts').add({
                        'name': _name,
                        'jobTitle': _jobTitle,
                        'location': _location,
                        'postText': _postText,
                        'likes': _likes,
                        'comments': _comments,
                        'shares': _shares,
                        'imageUrl': imageUrl,
                        'createdAt': Timestamp.now(),
                      });

                      Navigator.pop(context);
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
