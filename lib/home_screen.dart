import 'package:alumni_admin/create_post.dart';
import 'package:alumni_admin/invitation_page.dart';
import 'package:alumni_admin/register_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if(_selectedIndex==1){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InvitationPage()));
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Alumni Admin App'),
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
                  count: 500,
                ),
                AlumniCounter(
                  label: 'Active Alumni',
                  count: 300,
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
                    Navigator.push(context, MaterialPageRoute(builder:
                    (context)=> RegistrationPage()));
                    // Navigate to add alumni page
                  },
                  child: Text('Add Alumni'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:
                      (context)=> CreatePostPage()));
                    // Navigate to create post page
                  },
                  child: Text('Create Post'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
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
