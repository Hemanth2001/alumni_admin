import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alumni Feed'),
      ),
      body: ListView(
        children: [
          _buildPost(
            context,
            profileImage: AssetImage('assets/profile.png'),
            name: 'John Doe',
            postImage: AssetImage('images/post_image_1.png'),
            caption: 'This is a sample post caption',
          ),
          _buildPost(
            context,
            profileImage: AssetImage('assets/profile.png'),
            name: 'Jane Smith',
            postImage: AssetImage('images/post_image_2.png'),
            caption: 'Another post caption',
          ),
        ],
      ),
    );
  }

  Widget _buildPost(
      BuildContext context, {
        required ImageProvider<Object> profileImage,
        required String name,
        required ImageProvider<Object> postImage,
        required String caption,
      }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24.0,
                backgroundImage: profileImage,
              ),
              SizedBox(width: 16.0),
              Text(
                name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Image(image: postImage),
          SizedBox(height: 16.0),
          Text(
            caption,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.thumb_up),
              ),
              Text('12 likes'),
              SizedBox(width: 16.0),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.comment),
              ),
              Text('4 comments'),
            ],
          ),
        ],
      ),
    );
  }
}
