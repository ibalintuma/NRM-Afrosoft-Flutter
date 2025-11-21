import 'package:flutter/material.dart';
import 'package:nrm_afrosoft_flutter/Community/CreatePost.dart';
import 'package:nrm_afrosoft_flutter/Community/video_player_widget.dart';

import '../Utils/Constants.dart';
import '../Utils/Helper.dart';

class PostPage extends StatefulWidget {
  //const PostPage({super.key});

  dynamic post;
  PostPage({super.key, this.post});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {



  @override
  void initState() {
    super.initState();
    print( widget.post);
    getPost();
  }


  var _loadingPost = false;
  var _posts = [];
  void getPost() {

    if( widget.post == null) {
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
    } else {
      setState(() {
        _posts = widget.post["comments"];
        print(_posts);
        _title = "Comments";

      });
    }
  }






















  String _formatDate(dynamic date) {
    if (date is DateTime) {
      return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
    }
    return "";
  }

  var _title = "Community";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          _title,
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
          heroTag: widget.post == null ? 'POST' : 'COMMENT',
          onPressed: () async {
            // Open chat screen
            var a = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddPostPage(post: widget.post)),);
            if (a == true) {
              if( widget.post == null) {
                getPost();
                //show snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Post created successfully"),
                  ),
                );
              } else {
                Navigator.pop(context, true);
                //show snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Comment added successfully"),
                  ),
                );
              }
            }
          },
          backgroundColor: Colors.black,
          icon: const Icon(Icons.edit, color: Color(0xFFFFD401)),
          label: Text(
            widget.post == null ? 'POST' : 'COMMENT',
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
        //print("${ getImageURL("CommunityPostFiles",post["video"])}");

        //{user_name: Ahimbisibwe Innocent, picture: , id: 811, comment: happy to be in our party , date: 2025-11-18 22:56:14, likes: 0}

        return Card(
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 1,
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
                        if (post["user_name"] == null || post["user_name"]!.isEmpty)
                          const Text("Anonymous", style: TextStyle(fontWeight: FontWeight.bold),)
                        else
                            Text(post["user_name"] ?? "...", style: const TextStyle(fontWeight: FontWeight.bold),),
                        Text(
                          "${post["date_time"] ?? post["date"]}",
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
                    if (post["message"] != null && post["message"]!.isNotEmpty)
                    Text(
                      post["message"] ?? "ni",
                      style: const TextStyle(fontSize: 14),
                    ),

                    if (post["comment"] != null && post["comment"]!.isNotEmpty)
                    Text(
                      post["comment"] ?? "ni",
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
                      VideoPlayerWidget(
                        videoUrl: getImageURL("CommunityPostFiles", post["video"]),
                      ),
                  ],
                ),
              ),


              if( post["reply"] != null && post["reply"]!.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFD401), // border color
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 12.0, ).copyWith(bottom: 8.0),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Reply From NRM App Support Center", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                    SizedBox(height: 2,),
                    Text("${post["reply"]}", style: TextStyle(fontSize: 13),),
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
                          "${post['likes']}",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "${post['comments_count'] ?? "..."} Comments",
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
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        dynamic oldLikes = post["likes"];
                        int likes = 0;

                        if (oldLikes is String) {
                          likes = int.tryParse(oldLikes) ?? 0;
                        } else if (oldLikes is! int) {
                          likes = 0;
                        }

                        int newLikes = likes + 1;

                        setState(() {
                          _posts[index]["likes"] = "$newLikes";
                        });





                        print("objectx = ${post["id"]}");
                        // Send like to server
                        requestAPI(
                          getApiURL("like_community_post.php"),
                          {"post_id": "${post["id"]}"},
                              (loading) {
                            setState(() {
                              //_loading_events = loading;
                            });
                          },
                              (response) {
                            print("event = $response");

                          },
                              (error) {
                            print("error = $error");
                              },
                          method: "POST",
                        );





                      },
                      icon: const Icon(Icons.thumb_up_off_alt, size: 20),
                      label: const Text("Like"),
                    ),
                    TextButton.icon(
                      onPressed: () async {
                       var refresh =  await Navigator.push(context, MaterialPageRoute(builder: (context) => PostPage( post: post) ) );
                       if( refresh == true) {
                         getPost();
                       }
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
              const SizedBox(height: 4),
            ],
          ),
        );
      },
    );
  }
}


