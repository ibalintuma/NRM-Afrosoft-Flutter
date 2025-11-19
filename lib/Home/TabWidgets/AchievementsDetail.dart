import 'package:flutter/material.dart';

import '../../Utils/Constants.dart';

class AchievementsDetail extends StatefulWidget {


  final dynamic achievement;
  const AchievementsDetail({super.key, this.achievement});

  @override
  State<AchievementsDetail> createState() => _AchievementsDetailState();
}

class _AchievementsDetailState extends State<AchievementsDetail> {
  // Demo data for now — can later come from API
  var achievements = [];

  @override
  void initState() {
    super.initState();
    achievements = widget.achievement['achievements'] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(widget.achievement['title'] ?? 'Achievements'),
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
                    getImageURL(
                      "AchievementImages",
                      achievement["image"],
                    ),
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
                          achievement["name"]!,
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
