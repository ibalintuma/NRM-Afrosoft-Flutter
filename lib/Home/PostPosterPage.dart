import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'dart:io';

import '../Utils/Constants.dart';
import '../Utils/Helper.dart';

class PostPosterPage extends StatefulWidget {
  const PostPosterPage({super.key});

  @override
  State<PostPosterPage> createState() => _PostPosterPageState();
}

class _PostPosterPageState extends State<PostPosterPage> {
  File? _selectedImage;
  final picker = ImagePicker();
  bool isPosting = false;

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  var _loadingData = false;
  Future<void> _postPoster() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an image first")),
      );
      return;
    }

    //if user is not logged in
    var preferences = await SharedPreferences.getInstance();
    var user = preferences.getString("user") ?? "";
    if(!user.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please log in to post a poster")),
      );
      return;
    }




      //poster,message,user_id

    var _user = jsonDecode(user);
    var user_id = _user["id"] ?? "";

    String fileName = _selectedImage!.path.split('/').last;
    requestAPI(getApiURL("upload_campaign_poster.php"), {
      "poster": await MultipartFile.fromFile(_selectedImage!.path, filename: fileName),
      "message": "no message",
      "user_id": user_id,
    }, (loading){
      setState(() {
        _loadingData = loading;
      });
    }, (response){

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Poster uploaded successfully!")),
      );

      setState(() => _selectedImage = null);

      Navigator.pop(context);

    }, (error){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Caution; failed to submit')),
      );
    }, method: "POST");








  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Post Poster"),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFD401),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Upload Container
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 280,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: const Offset(2, 3),
                    ),
                  ],
                ),
                child:
                    _selectedImage == null
                        ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate_outlined,
                              color: Colors.grey[600],
                              size: 80,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Tap to upload a poster",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        )
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
              ),
            ),

            const SizedBox(height: 24),

            if(_loadingData)
              bossBaseLoader(),

            // Post Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon:
                    isPosting
                        ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                        : const Icon(Icons.upload_rounded, color: Colors.white),
                label: Text(
                  isPosting ? "Posting..." : "Post Poster",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD401),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                onPressed: isPosting ? null : _postPoster,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
