import 'package:flutter/material.dart';
import '../../Utils/Constants.dart';
import '../../Utils/Helper.dart';
import 'package:share_plus/share_plus.dart'; // add this package for sharing

class NewsDetailPage extends StatelessWidget {
  final Map<String, dynamic> news;

  const NewsDetailPage({super.key, required this.news});

  void _shareNews(BuildContext context) {
    final String url = getImageURL("NewsImages", news["image"]);
    Share.share('${news["headline"]}\n\n${news["body"]}\n\nRead more: $url');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // SliverAppBar with collapsing image
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white),
            expandedHeight: 250,
            pinned: true,
            stretch: true,
            backgroundColor: const Color(0xFFFFD401),
            foregroundColor: Colors.black87,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                getImageURL("NewsImages", news["image"]),
                fit: BoxFit.cover,
              ),
              collapseMode: CollapseMode.parallax,
            ),
          ),

          // Content below app bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Heading
                  Text(
                    news["headline"],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Date
                  Text(
                    formatLaravelTime(news["date"]),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 94, 128, 186),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Divider with share icon
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Color.fromARGB(255, 94, 128, 186),
                          thickness: 1,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => _shareNews(context),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.share,
                            color: const Color(0xFFFFD401),
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // News Body
                  Text(
                    news["body"],
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
