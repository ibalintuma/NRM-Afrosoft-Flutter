import 'package:flutter/material.dart';
import 'package:nrm_afrosoft_flutter/Community/CreatePost.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final List<Map<String, dynamic>> _posts = [
    {
      "person": {"name": "John Doe"},
      "created_at": DateTime.now().subtract(const Duration(hours: 1)),
      "message": "Hello NRM community! Excited to be here.",
      "picture": null,
      "count_likes": 3,
      "count_comments": 2,
    },
    {
      "person": {"name": "Jane Smith"},
      "created_at": DateTime.now().subtract(const Duration(hours: 2)),
      "message": "Check out this amazing event happening this weekend!",
      "picture": "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
      "count_likes": 5,
      "count_comments": 1,
    },
  ];

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
      body: _buildPostsList(),
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
          onPressed: () {
            // Open chat screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPostPage()),
            );
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
                        "assets/drawable/chairman.jpg",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post["person"]?["name"] ?? "Unknown User",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _formatDate(post["created_at"]),
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
                      post["message"] ?? "",
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    if (post["picture"] != null && post["picture"]!.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          post["picture"]!,
                          fit: BoxFit.cover,
                        ),
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
                          "${post['count_likes']} Likes",
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
                          "${post['count_comments']} Comments",
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
                          post["count_likes"] = (post["count_likes"] ?? 0) + 1;
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
