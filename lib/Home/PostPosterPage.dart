import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<void> _postPoster() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an image first")),
      );
      return;
    }

    setState(() => isPosting = true);
    await Future.delayed(const Duration(seconds: 2)); // simulate upload
    setState(() => isPosting = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Poster uploaded successfully!")),
    );

    setState(() => _selectedImage = null);
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
