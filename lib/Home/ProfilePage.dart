import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _avatarImage;

  final String username = "John Doe";
  final String email = "john.doe@example.com";
  final String district = "Kampala";

  final ImagePicker _picker = ImagePicker();

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
                          : const AssetImage('assets/images/profile_icon.png')
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
}
