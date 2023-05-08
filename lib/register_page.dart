import 'package:alumni_admin/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _nameController = TextEditingController();
  final _yearController = TextEditingController();
  final _usnController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _locationController = TextEditingController();
  final _profession = TextEditingController();
  final _password = TextEditingController();

  Future<void> register() async {
    final userRef = FirebaseFirestore.instance.collection('users').doc(_usnController.text);
    await userRef.set({
      'name': _nameController.text,
      'usn':_usnController.text,
      'year': int.parse(_yearController.text),
      'mobile': int.parse(_mobileController.text),
      'email': _emailController.text,
      'location': _locationController.text,
      'profession': _profession.text,
      'password': _password.text,
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage()));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 24.0),
              Text(
                'Register',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.0),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  hintText: 'Enter your name',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _yearController,
                decoration: InputDecoration(
                  labelText: 'Year of Passing',
                  border: OutlineInputBorder(),
                  hintText: 'Enter your year of passing',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _usnController,
                decoration: InputDecoration(
                  labelText: 'USN',
                  border: OutlineInputBorder(),
                  hintText: 'Enter your USN',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _mobileController,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  border: OutlineInputBorder(),
                  hintText: 'Enter your mobile number',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  hintText: 'Enter your email address',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Current Location',
                  border: OutlineInputBorder(),
                  hintText: 'Enter your current location',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _profession,
                decoration: InputDecoration(
                  labelText: 'Profession',
                  border: OutlineInputBorder(),
                  hintText: 'Profession',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _password,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  register();
                  // handle registration
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
