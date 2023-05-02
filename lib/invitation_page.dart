import 'package:flutter/material.dart';

class InvitationPage extends StatelessWidget {
  const InvitationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invitation'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('images/post_image_1.png'),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Invitation from Jane Doe',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Image.asset(
                'images/post_image_1.png',
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Are you joining us?'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
