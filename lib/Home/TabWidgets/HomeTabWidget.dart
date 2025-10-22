import 'package:flutter/material.dart';
import 'package:nrm_afrosoft_flutter/Home/TabWidgets/AskPresidentPage.dart';

import '../../Utils/Constants.dart';
import '../../Utils/Helper.dart';
import 'NewsDetailPage.dart';

class HomeTabWidget extends StatefulWidget {
  const HomeTabWidget({super.key});

  @override
  State<HomeTabWidget> createState() => _HomeTabWidgetState();
}

class _HomeTabWidgetState extends State<HomeTabWidget> {
  // Sample news data (can later come from your API)

  @override
  void initState() {
    super.initState();
    getNews();
  }

  var _loadingNews = false;
  var _news = [];
  void getNews() {
    //requestAPI(getApiURL("retrieve_campaign_posts.php"), {"":""}, (loading){}, (response){}, (error){}, method: "GET");
    requestAPI(
      getApiURL("retrieve_all_news.php"),
      {"": ""},
      (loading) {
        setState(() {
          _loadingNews = loading;
        });
      },
      (response) {
        print("_NEWS");
        setState(() {
          _news = response;
        });
        print(_news);
      },
      (error) {},
      method: "GET",
    );
  }

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
              itemCount: _news.length,
              itemBuilder: (context, index) {
                final news = _news[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NewsDetailPage(news: news),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        // News Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            getImageURL("NewsImages", news["image"]),
                            height: 220,
                            width: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Yellow "NEWS UPDATE" label
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
                        // Description & Date
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
                                Expanded(
                                  child: Text(
                                    news["headline"],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  formatLaravelTime(news["date"]),
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
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AskPresidentPage()),
              );
            },
            child: Container(
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
                        Container(
                          height: 2,
                          color: Color(0xFFFFD401),
                          width: 80,
                        ),
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

          const SizedBox(height: 16),

          // 🔶 Second Row with Background Images
          Row(
            children: [
              // Left: Background Image 1
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/drawable/manifesto_image.PNG',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Right: Background Image 2
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: const DecorationImage(
                          image: AssetImage('assets/drawable/leadership.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 🔶 Third Row with RDCs and NRM Candidates
          Row(
            children: [
              // Left: RDCs and DRDCs
              Expanded(
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/drawable/nrm_logo.png', // 👈 your NRM logo
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "RDC's and DRDC's",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Right: NRM Candidates
              Expanded(
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD401),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/drawable/nrm_logo.png', // 👈 same logo
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'NRM Candidates',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 🌍 Near You Section
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: AssetImage(
                  'assets/drawable/near_you.jpg',
                ), // 👈 background image
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Semi-transparent overlay for clarity
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),

                // Icon + Text vertically aligned
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFD401), // Yellow background for icon
                      ),
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.black,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Near You',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 🟨 Two Containers Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // First container
              Expanded(
                child: Container(
                  height: 100,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/drawable/road_map.png',
                      ), // 👈 replace with your image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // Second container
              Expanded(
                child: Container(
                  height: 100,
                  margin: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/drawable/contact.jpg',
                      ), // 👈 replace with your image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 🟩 Last Full-Width Container
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: AssetImage(
                  'assets/drawable/web_logo.png',
                ), // 👈 replace with your image
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
