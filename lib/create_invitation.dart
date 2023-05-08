import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InvitationAdminPage extends StatefulWidget {
  const InvitationAdminPage({Key? key}) : super(key: key);

  @override
  _InvitationAdminPageState createState() => _InvitationAdminPageState();
}

class _InvitationAdminPageState extends State<InvitationAdminPage> {
  final _formKey = GlobalKey<FormState>();
  String _eventName = '';
  DateTime _eventDate = DateTime.now();
  String _eventLocation = '';
  String _eventDetails = '';
  int _userCount = 0;
  File? _image;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Upload the image to Firebase Storage.
      if (_image != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('invitation_images')
            .child(DateTime.now().millisecondsSinceEpoch.toString());
        await storageRef.putFile(_image!);
        final imageUrl = await storageRef.getDownloadURL();

        // Add the invitation details to Firebase Firestore.
        await FirebaseFirestore.instance.collection('invitation').add({
          'event_name': _eventName,
          'event_date': _eventDate,
          'event_location': _eventLocation,
          'event_details': _eventDetails,
          'user_count': _userCount,
          'image_url': imageUrl,
        });

        // Display a confirmation message to the admin.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invitation created successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select an image.')),
        );
      }
    }
  }

  void _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Invitation'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Event Name',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the event name.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _eventName = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Event Date and Time',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2025),
                    );
                    if (date != null) {
                      final TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        setState(() {
                          _eventDate = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            time.hour,
                            time.minute,
                          );
                        });
                      }
                    }
                  },
                  child: Text(_eventDate.toString()),
                ),
                const SizedBox(height: 16),
                Text(
                  'Event Location',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the event location.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _eventLocation = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Event Details',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the event details.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _eventDetails = value;
                    });
                  },
                  maxLines: 5,
                ),
                const SizedBox(height: 16),
                Text(
                  'User Count',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the user count.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _userCount = int.tryParse(value) ?? 0;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Invitation Image',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 8),
                Center(
                  child: _image == null
                      ? ElevatedButton(
                          onPressed: _getImage,
                          child: Text('Select Image'),
                        )
                      : Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Image.file(_image!),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _image = null;
                                });
                              },
                              child: Icon(Icons.delete),
                            ),
                          ],
                        ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Create Invitation'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
