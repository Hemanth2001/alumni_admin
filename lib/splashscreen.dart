import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alumni_admin/home_screen.dart';
import 'package:alumni_admin/login_screen.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  Future<void> _checkIfLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int isLoggedIn = prefs.getInt('isLoggedIn') ?? 0;
    if (isLoggedIn == 0) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) =>LoginScreen()));
      });
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'images/logo.jpg',
          width: 300.0,
          height: 100.0,
        ),
      ),
    );
  }
}
