import 'package:flutter/material.dart';

class AchievementsDetail extends StatefulWidget {
  const AchievementsDetail({super.key});

  @override
  State<AchievementsDetail> createState() => _AchievementsDetailState();
}

class _AchievementsDetailState extends State<AchievementsDetail> {
  // Demo data for now — can later come from API
  final List<Map<String, String>> achievements = [
    {
      "image": "https://picsum.photos/400/200?1",
      "title": "Digital Transformation in Agriculture",
      "description":
          "Implemented a digital platform that connects farmers with markets, weather updates, and agronomist support, improving productivity across regions.",
    },
    {
      "image": "https://picsum.photos/400/200?2",
      "title": "Youth Empowerment Initiative",
      "description":
          "Trained over 10,000 youth in ICT and entrepreneurship skills, creating job opportunities and boosting innovation across rural communities.",
    },
    {
      "image": "https://picsum.photos/400/200?3",
      "title": "Health Access Expansion",
      "description":
          "Deployed mobile health applications to improve access to medical consultations and health record management in underserved areas.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(achievements[0]['title'] ?? 'Achievements'),
        backgroundColor: Color(0xFFFFD401),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          final achievement = achievements[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image section
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.network(
                    achievement["image"]!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Text section
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          achievement["title"]!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 94, 128, 186),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        achievement["description"]!,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
