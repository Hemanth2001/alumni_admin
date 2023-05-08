import 'package:alumni_admin/create_invitation.dart';
import 'package:alumni_admin/create_post.dart';
import 'package:alumni_admin/invitation_page.dart';
import 'package:alumni_admin/login_screen.dart';
import 'package:alumni_admin/register_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String id ="";
  int total=0;
  void initState() {
    super.initState();
   sd();
   getTotalUsersCount();
   print(total);

  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('isLoggedIn', 0);
    prefs.setString('ID', "");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }


  Future<void> getTotalUsersCount() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('users').get();
    print(querySnapshot.size.toInt());
    setState(() {
      total= querySnapshot.size.toInt();

    });
  }



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (_selectedIndex == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InvitationPage()));
      }
    });
  }
  Future<String> sd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString('ID').toString();
    });


    return id;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Alumni Admin App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('images/profile_image.jpg'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                   id,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'admin@svce.edu.in',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                // navigate to profile page
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Invitations'),
              onTap: () {
                Navigator.pop(context);
                // navigate to invitations page
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Friends'),
              onTap: () {
                Navigator.pop(context);
                // navigate to friends page
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                logout();
                // navigate to friends page
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AlumniCounter(
                  label: 'Total Alumni',
                  count: total,
                ),
                AlumniCounter(
                  label: 'Active Alumni',
                  count: 1,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationPage()));
                    // Navigate to add alumni page
                  },
                  child: Text('Add Alumni'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreatePostPage()));
                    // Navigate to create post page
                  },
                  child: Text('Create Post'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InvitationAdminPage()));
                    // Navigate to create invitation page
                  },
                  child: Text('Create Invitation'),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Invitations',
          ),
        ],
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
      ),
    );
  }
}

class AlumniCounter extends StatelessWidget {
  final String label;
  final int count;

  AlumniCounter({
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
