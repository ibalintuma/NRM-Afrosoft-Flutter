import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../Utils/Constants.dart';
import '../Utils/Helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class AddPostPage extends StatefulWidget {

  dynamic post;
  AddPostPage({super.key, this.post});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();
  File? _selectedImage;
  File? _selectedVideo;
  VideoPlayerController? _videoController;
  bool _submitting = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
        _selectedVideo = null;
        _videoController?.dispose();
        _videoController = null;
      });
    }
  }

  Future<void> _pickVideo() async {
    final picked = await _picker.pickVideo(source: ImageSource.gallery);
    if (picked != null) {
      _videoController?.dispose();
      _videoController = VideoPlayerController.file(File(picked.path))
        ..initialize().then((_) {
          setState(() {});
          _videoController?.setLooping(true);
          _videoController?.play();
        });

      setState(() {
        _selectedVideo = File(picked.path);
        _selectedImage = null;
      });
    }
  }





  var _loadingSubmit = false;
  Future<void> _submitPost() async {
    print("custom-ok");

    _formKey.currentState?.save();


    var preferences = await SharedPreferences.getInstance();
    var user = preferences.getString("user") ?? "";
    var _user = jsonDecode(user);
    var user_id = _user["id"] ?? "";
    var message = _messageController.text.trim();

    print("objectuuu = $user_id");

    if ( widget.post == null) {
      //new post
      print("posting...");
      requestAPI(
        getApiURL("upload_community_post.php"),
        {
          "user_id": user_id,
          "message": message,
          if (_selectedImage != null)
            'picture': await MultipartFile.fromFile(
              _selectedImage!.path, filename: "picture.jpg",),
          if (_selectedVideo != null)
            'video': await MultipartFile.fromFile(
              _selectedVideo!.path, filename: "video.mp4",),
          //"video": "",
          //"picture": "",
        },
            (loading) {
          setState(() {
            _loadingSubmit = loading;
          });
        }, (response) {
        if (response["code"] == 1) {
          Navigator.pop(context, true);
        } else {

        }
      }, (error) {
        print("error");
      },
        method: "POST",
      );
    } else {
      //comment
      print("commenting...");

      requestAPI(
        getApiURL("comment_to_post.php"),
        {
          "user_id": user_id,
          "post_id": widget.post["id"].toString(),
          "comment": message,
        },
            (loading) {
          setState(() {
            _loadingSubmit = loading;
          });
        }, (response) {
          print(response);
        Navigator.pop(context, true);
      }, (error) {
        Navigator.pop(context, true);
        print("error");
      },
        method: "POST",
      );
    }

  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.post == null ? "Create Post" : "Add Comment",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFD401),
        elevation: 1,
        actions: [
          TextButton(
            onPressed: _submitting ? null : _submitPost,
            child: const Text(
              'POST',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Label above message field
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Add your message",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),

              // Post message card
              Form(
                key: _formKey,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey.shade400,
                    ), // grey border
                  ),
                  child: TextFormField(
                    controller: _messageController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: "Communicate something? ...",
                      border: InputBorder.none,
                    ),
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? "Message is required"
                                : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              if (_loadingSubmit)
                Center(child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: bossBaseLoader(),
                )),

              // Image preview
              if (_selectedImage != null)
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(
                        _selectedImage!,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            setState(() => _selectedImage = null);
                          },
                        ),
                      ),
                    ),
                  ],
                ),

              // Video preview
              if (_selectedVideo != null &&
                  _videoController != null &&
                  _videoController!.value.isInitialized)
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: AspectRatio(
                        aspectRatio: _videoController!.value.aspectRatio,
                        child: VideoPlayer(_videoController!),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              _selectedVideo = null;
                              _videoController?.dispose();
                              _videoController = null;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),

              const Spacer(),

              // Add Photo / Video row
              if( widget.post == null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.photo, color: Colors.blueAccent),
                    label: const Text(
                      "Add Photo",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: _pickVideo,
                    icon: const Icon(Icons.videocam, color: Colors.blueAccent),
                    label: const Text(
                      "Add Video",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
