import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart'; // for sharing

class LeadersDetailPage extends StatefulWidget {
  final Map<String, String>? leader; // accept leader data (optional for now)

  const LeadersDetailPage({super.key, this.leader});

  @override
  State<LeadersDetailPage> createState() => _LeadersDetailPageState();
}

class _LeadersDetailPageState extends State<LeadersDetailPage> {
  @override
  Widget build(BuildContext context) {
    final leader =
        widget.leader ??
        {
          'name': 'Yoweri Kaguta Museveni',
          'role': 'National Chairperson',
          'image': 'assets/drawable/chairman.jpg', // placeholder image
        };

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 94, 128, 186),
      appBar: AppBar(
        title: Text('NRM Leader'),
        backgroundColor: Color(0xFFFFD401),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ===== Top Container =====
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Color(0xFFFFD401)),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            leader['image'] ?? 'assets/drawable/person.jpg',
                            width: double.infinity,
                            height: 250,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            leader['name'] ?? '',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            leader['role'] ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 94, 128, 186),
                            ),
                          ),
                        ],
                      ),

                      // Share icon at bottom right
                      Positioned(
                        right: 12,
                        bottom: 2,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 94, 128, 186),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.share, color: Colors.black),
                            onPressed: () {
                              Share.share(
                                "Check out ${leader['name']}, ${leader['role']} (NRM)",
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ===== Info Card =====
            Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "About",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(color: Color.fromARGB(255, 94, 128, 186)),
                    const SizedBox(height: 6),
                    const Text(
                      "Will be provided later",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      "Contacts",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(color: Color.fromARGB(255, 94, 128, 186)),
                    const SizedBox(height: 8),

                    // Phone
                    Row(
                      children: const [
                        Icon(Icons.phone, color: Colors.black),
                        SizedBox(width: 10),
                        Text(
                          "Will be provided later",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Email
                    Row(
                      children: const [
                        Icon(Icons.email, color: Colors.black),
                        SizedBox(width: 10),
                        Text(
                          "Will be provided later",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
