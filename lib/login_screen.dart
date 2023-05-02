import 'package:alumni_admin/feed_page.dart';
import 'package:alumni_admin/home_screen.dart';
import 'package:alumni_admin/register_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usnController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _usnController.text = prefs.getString('savedUsn') ?? '';
      _passwordController.text = prefs.getString('savedPassword') ?? '';
      _rememberMe = prefs.getBool('rememberMe') ?? false;
    });
  }

  Future<void> _saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedUsn', _usnController.text);
    await prefs.setString('savedPassword', _passwordController.text);
    await prefs.setBool('rememberMe', _rememberMe);
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    // TODO: Implement your own login logic here using the entered USN and password

    // Simulating a delay for 3 seconds
    await Future.delayed(Duration(seconds: 3));

    if (_rememberMe) {
      await _saveCredentials();
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void _register() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //     appBar: AppBar(
      //     title: Text('Login'),
      // ),
      body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 150.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 32.0),
                  child: Text(
                    'Welcome back!',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: TextField(
                    controller: _usnController,
                    decoration: InputDecoration(
                      labelText: 'ID',
                      border: OutlineInputBorder(),
                      hintText: 'Enter your ID',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      hintText: 'Enter your password',
                    ),
                    obscureText: true,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                      ),
                      Text('Remember me'),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      padding: EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 16.0),
                      textStyle: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text('Log In'),
                  ),
                ),
                // Container(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       TextButton(
                //         onPressed: () {},
                //         child: Text('Forgot password?'),
                //       ),
                //       Text(' | '),
                //       TextButton(
                //         onPressed: () {_register();},
                //         child: Text('Sign up'),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),

    );
  }
}
