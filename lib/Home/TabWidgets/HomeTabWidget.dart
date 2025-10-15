import 'package:flutter/material.dart';

class HomeTabWidget extends StatefulWidget {
  const HomeTabWidget({super.key});

  @override
  State<HomeTabWidget> createState() => _HomeTabWidgetState();
}

class _HomeTabWidgetState extends State<HomeTabWidget> {
  // Sample news data (can later come from your API)
  final List<Map<String, String>> latestNews = [
    {
      "image": "assets/drawable/launch_one.jpg",
      "title": "President launches new agricultural initiative",
      "date": "Oct 10, 2025",
    },
    {
      "image": "assets/drawable/launch_two.jpg",
      "title": "NRM Youth Conference held in Kampala",
      "date": "Oct 12, 2025",
    },
    {
      "image": "assets/drawable/launch_three.jpg",
      "title": "Government unveils new infrastructure projects",
      "date": "Oct 14, 2025",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Title
          const Text(
            "Latest News",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          // ✅ Horizontal News Slider
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: latestNews.length,
              itemBuilder: (context, index) {
                final news = latestNews[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Stack(
                    children: [
                      // News Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          news["image"]!,
                          height: 220,
                          width: 300,
                          fit: BoxFit.cover,
                        ),
                      ),

                      // Yellow "NEWS UPDATE" label (top-left)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD401),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            "NEWS UPDATE",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),

                      // News Description (bottom)
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(12),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Description
                              Expanded(
                                child: Text(
                                  news["title"]!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              // Date (bottom right)
                              Text(
                                news["date"]!,
                                style: const TextStyle(
                                  color: Color(0xFFFFD401),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.yellow, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                // Left text part
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'NRM CHAIRMAN',
                        style: TextStyle(
                          color: Color(0xFFFFD401),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(height: 2, color: Color(0xFFFFD401), width: 80),
                      const SizedBox(height: 8),
                      const Text(
                        'H.E Yoweri Kaguta Museveni',
                        style: TextStyle(
                          color: Color(0xFFFFD401),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                // Right image
                ClipRRect(
                  child: Image.asset(
                    'assets/drawable/hero.png', // 👈 Replace with your asset image
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), // Spacing at the bottom;
          Row(
            children: [
              // Left: Gradient Container
              Expanded(
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: [Colors.yellow, Colors.black],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Central Executive Committee (CEC)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Right: Background Image with Overlay
              Expanded(
                child: Stack(
                  children: [
                    // Background image
                    Container(
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/drawable/todwong_small.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Dark overlay
                    Container(
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    // Centered text
                    const Positioned.fill(
                      child: Center(
                        child: Text(
                          'General Secretary',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
