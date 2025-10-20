import 'package:flutter/material.dart';
import 'package:nrm_afrosoft_flutter/Community/CreatePost.dart';
import 'package:video_player/video_player.dart';

import '../Utils/Constants.dart';
import '../Utils/Helper.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {


  @override
  void initState() {
    super.initState();
    getPost();
  }


  var _loadingPost = false;
  var _posts = [];
  void getPost() {
    requestAPI(
      getApiURL("retrieve_community_posts.php"),
      {"": ""},
          (loading) {
        setState(() {
          _loadingPost = loading;
        });
      }, (response) {
        setState(() {
          _posts = response;
        });
      },
          (error) {},
      method: "GET",
    );
  }






















  String _formatDate(dynamic date) {
    if (date is DateTime) {
      return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'CREATE POST',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Community",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFFFFD401),
        elevation: 0,
      ),
      body:
      _loadingPost ? Center(child: bossBaseLoader()) :
      _buildPostsList(),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(
              color: Color(0xFFFFD401), // border color
              width: 2, // border thickness
            ),
          ),
          heroTag: 'POST',
          onPressed: () async {
            // Open chat screen
            var a = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddPostPage()),);
            if (a == true) {
              getPost();
            }
          },
          backgroundColor: Colors.black,
          icon: const Icon(Icons.edit, color: Color(0xFFFFD401)),
          label: const Text(
            'POST',
            style: TextStyle(
              color: Color(0xFFFFD401),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPostsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _posts.length,
      itemBuilder: (context, index) {

        final post = _posts[index];
        //print("${ getImageURL("CommunityPostFiles",post["picture"])}");
        print("${ getImageURL("CommunityPostFiles",post["video"])}");

        return Card(
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(
                        "assets/drawable/img_placeholder.jpg",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post["user_name"] ?? "...",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${post["date_time"]}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Post message & image
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post["message"] ?? "ni",
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    if (post["image"] != null && post["image"]!.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          getImageURL("CommunityPostFiles", post["image"]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    if (post["video"] != null && post["video"]!.isNotEmpty)
                      _VideoPlayerWidget(
                        videoUrl: getImageURL("CommunityPostFiles", post["video"]),
                      ),
                  ],
                ),
              ),

              // Likes & Comments row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.thumb_up,
                          size: 18,
                          color: Colors.blue.shade700,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${post['likes']} Likes",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.comment,
                          size: 18,
                          color: Colors.grey.shade700,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${post['comments_count']} Comments",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Action buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          post["likes"] = (post["likes"] ?? 0) + 1;
                        });
                      },
                      icon: const Icon(Icons.thumb_up_off_alt, size: 20),
                      label: const Text("Like"),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        // TODO: Navigate to comments page
                      },
                      icon: const Icon(Icons.comment_outlined, size: 20),
                      label: const Text("Comment"),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Share feature removed"),
                          ),
                        );
                      },
                      icon: const Icon(Icons.share_outlined, size: 20),
                      label: const Text("Share"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}



class _VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const _VideoPlayerWidget({required this.videoUrl});

  @override
  State<_VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<_VideoPlayerWidget> {
  VideoPlayerController? _controller;
  bool _isPlaying = false;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _initializeAndPlay() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          _isPlaying = true;
        });
        _controller!.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isPlaying) {
      return GestureDetector(
        onTap: _initializeAndPlay,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 200,
                color: Colors.black12,
                child: const Center(
                  child: Icon(Icons.videocam, size: 50, color: Colors.grey),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(12),
                child: const Icon(
                  Icons.play_arrow,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return _controller!.value.isInitialized
        ? ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AspectRatio(
        aspectRatio: _controller!.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            VideoPlayer(_controller!),
            VideoProgressIndicator(_controller!, allowScrubbing: true),
          ],
        ),
      ),
    )
        : const SizedBox(
      height: 200,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}