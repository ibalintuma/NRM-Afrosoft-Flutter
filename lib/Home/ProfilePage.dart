import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nrm_afrosoft_flutter/Utils/Constants.dart';
import 'package:nrm_afrosoft_flutter/Utils/Helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _avatarImage;

  final ImagePicker _picker = ImagePicker();

  initState() {
    super.initState();
    getPerson();
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source:
          await showDialog<ImageSource>(
            context: context,
            builder:
                (context) => SimpleDialog(
                  title: const Text("Select image source"),
                  children: [
                    SimpleDialogOption(
                      onPressed:
                          () => Navigator.pop(context, ImageSource.camera),
                      child: const Text("Camera"),
                    ),
                    SimpleDialogOption(
                      onPressed:
                          () => Navigator.pop(context, ImageSource.gallery),
                      child: const Text("Gallery"),
                    ),
                  ],
                ),
          ) ??
          ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _avatarImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Modern AppBar
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD401),
        elevation: 2,
        toolbarHeight: 80,
        centerTitle: false,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Avatar with edit icon
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      _avatarImage != null
                          ? FileImage(_avatarImage!)
                          : NetworkImage( getImageURL("UserImages", picture) )
                              as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD401),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Personal Information section
            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username: $username',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text('Email: $email', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(
                    'District: $district',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Logout button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // handle logout
                  logoutPerson(context);
                  Navigator.pushReplacementNamed(context, '/splash');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD401),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text('Logout', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 12),

            // Delete Account button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // handle delete account
                  handleDeleteAccount(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'Delete Account',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  getPerson() async {
    var preferences = await SharedPreferences.getInstance();
    var user = preferences.getString("user") ?? "";
    var _user = jsonDecode(user);
    //{id: 6, user_name: Isaac Balintuma, picture: isaac_balintuma.jpeg, email: ibalintuma34@gmail.com, district: , password: 123456, firebase_token: fBY-orzvHkNjp3oP5uvOh7:APA91bGD8cXbZ48-QqnyFwBQeCIjXU6H-9mU-jXIch-D02yqwWq_Sk67IZU1zasqkspOm8VN-Nl-WDNXXV37unS5XjuCdPTKRkRJhsG5ysoPPDRTvQ94chupXcUB9d80XZBFWsRyboN0, notification_id: d022dba8-3ce0-4758-9f39-3c579c0fffad}

    username = _user['user_name'] ?? "";
    email = _user['email'] ?? "";
    district = _user['district'] ?? "";
    picture = _user['picture'] ?? "";

    setState(() {});
  }


  String picture = "picture";
  String username = "John Doe";
  String email = "john.doe@example.com";
  String district = "Kampala";

  void handleDeleteAccount(BuildContext context) {
    //this action cannot be undone, show a confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Account"),
        content: const Text(
            "Are you sure you want to delete your account? This action cannot be undone."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              //await deleteAccountAPI(context);
              logoutPerson(context);
              Navigator.pushReplacementNamed(context, '/splash');
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

}
