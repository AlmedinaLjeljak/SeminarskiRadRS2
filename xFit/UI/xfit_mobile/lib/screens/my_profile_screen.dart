import 'package:flutter/material.dart';

class MyProfileScreen extends StatefulWidget {
  MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  // Example user data (you can replace this with actual user data from a model or API)
  String username = "John Doe";
  String email = "johndoe@example.com";
  String bio = "This is the user's bio. It's a short description about the user.";
  String profileImageUrl = "https://www.example.com/profile.jpg"; // Replace with an actual URL or local image path

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit profile screen (you can create an EditProfileScreen if necessary)
              print("Edit profile clicked");
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(profileImageUrl), // You can replace with an AssetImage if you use a local image
              ),
            ),
            SizedBox(height: 20),
            // Username
            Text(
              username,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            // Email
            Text(
              email,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 20),
            // Bio Section
            Text(
              "Bio:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              bio,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 20),
            // Optionally add buttons or other actions
            ElevatedButton(
              onPressed: () {
                // Navigate to some other screen, e.g., to edit profile
                print("Save changes or go to another screen");
              },
              child: Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
