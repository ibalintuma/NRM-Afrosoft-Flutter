import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'VideoPlayerWidget.dart';

class VideosWidget extends StatefulWidget {
  const VideosWidget({super.key});

  @override
  State<VideosWidget> createState() => _VideosWidgetState();
}

class _VideosWidgetState extends State<VideosWidget> {
  // Demo data for now
  final List<Map<String, String>> demoVideos = [
    {
      "thumbnail": "assets/drawable/chairman.jpg",
      "title": "President Addresses the Nation",
      "date": "Oct 10, 2025",
      "url": "https://www.youtube.com/watch?v=ysz5S6PUM-U",
    },
    {
      "thumbnail": "assets/drawable/chairman.jpg",
      "title": "NRM Launches Youth Program",
      "date": "Oct 8, 2025",
      "url": "https://www.youtube.com/watch?v=9No-FiEInLA",
    },
    {
      "thumbnail": "assets/drawable/chairman.jpg",
      "title": "Minister of Agriculture Speech",
      "date": "Oct 6, 2025",
      "url": "https://www.youtube.com/watch?v=iLnmTe5Q2Qw",
    },
    {
      "thumbnail": "assets/drawable/chairman.jpg",
      "title": "NRM Community Outreach",
      "date": "Oct 5, 2025",
      "url": "https://www.youtube.com/watch?v=aqz-KE-bpKQ",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        itemCount: demoVideos.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // two per row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final video = demoVideos[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VideoPlayerScreen(videoUrl: video["url"]!),
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
                    child: Image.asset(
                      video["thumbnail"]!,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Date
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 8),
                    child: Text(
                      video["date"]!,
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
                      video["title"]!,
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
      ),
    );
  }
}
