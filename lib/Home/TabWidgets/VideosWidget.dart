import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../Utils/Constants.dart';
import '../../Utils/Helper.dart';
import 'VideoPlayerWidget.dart';

class VideosWidget extends StatefulWidget {
  const VideosWidget({super.key});

  @override
  State<VideosWidget> createState() => _VideosWidgetState();
}

class _VideosWidgetState extends State<VideosWidget> {
  var _loading_videos = false;
  var _videos = [];

  void get_videos() {
    requestAPI(
        "https://www.googleapis.com/youtube/v3/search",
        {
          "part": "snippet",
          "channelId": "UCl425fhkt272vtjvwPqC4Ww",
          "maxResults": "50",
          "key": "AIzaSyA8rbQlIK5KdmQRc6knpyE77QOISpaqtq4",
          "order": "date",
        }, (loading) {
      setState(() {
        _loading_videos = loading;
      });
    }, (response) {
      print("_videos");
      setState(() {
        readVideoResponse(response);
      });
      print(_videos);
    }, (error) {}, method: "GET");
  }

  @override
  void initState() {
    super.initState();
    get_videos();
  }

  @override
  Widget build(BuildContext context) {
    return _loading_videos
        ? Center(child: bossBaseLoader())
        : GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _videos.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // two per row
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final video = _videos[index];
        final snippet = video["snippet"];
        final videoId = video["id"]["videoId"];
        final title = snippet["title"];
        final description = snippet["description"];
        final publishTime = snippet["publishTime"];
        final thumbnail = snippet["thumbnails"]["medium"]["url"];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VideoPlayerScreen(
                    videoUrl: "https://www.youtube.com/watch?v=$videoId"),
              ),
            );
          },
          child: Card(
            color: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail image
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.network(
                    thumbnail,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // Date
                Padding(
                  padding: const EdgeInsets.only(top: 6, left: 8),
                  child: Text(
                    publishTime,
                    style: const TextStyle(
                      color: Color(0xFFFFD401),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Description
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void readVideoResponse(response) {
    setState(() {
      _videos = response["items"];
    });
  }
}