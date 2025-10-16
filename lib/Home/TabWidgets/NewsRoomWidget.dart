import 'package:flutter/material.dart';

class NewsRoomWidget extends StatefulWidget {
  const NewsRoomWidget({super.key});

  @override
  State<NewsRoomWidget> createState() => _NewsRoomWidgetState();
}

class _NewsRoomWidgetState extends State<NewsRoomWidget> {
  final List<Map<String, String>> demoNews = [
    {
      "title": "President Launches New Development Program",
      "date": "October 10, 2025",
      "image": "assets/drawable/sample_news_image.jpg",
    },
    {
      "title": "NRM Youth League Holds National Conference",
      "date": "October 8, 2025",
      "image": "assets/drawable/sample_news_image.jpg",
    },
    {
      "title": "Farmers Empowered with Modern Equipment",
      "date": "October 6, 2025",
      "image": "assets/drawable/sample_news_image.jpg",
    },
    {
      "title": "NRM Leaders Tour Eastern Uganda",
      "date": "October 4, 2025",
      "image": "assets/drawable/sample_news_image.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: List.generate(demoNews.length, (index) {
          final news = demoNews[index];
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left side: title, date, and read more
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            news["title"]!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            news["date"]!,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              // TODO: Navigate to details page
                            },
                            child: const Text(
                              "Read more...",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 10),

                    // Right side: image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        news["image"]!,
                        width: 100,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              if (index != demoNews.length - 1)
                const Divider(color: Colors.grey, thickness: 0.5),
            ],
          );
        }),
      ),
    );
  }
}
