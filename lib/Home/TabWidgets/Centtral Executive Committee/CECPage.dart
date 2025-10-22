import 'package:flutter/material.dart';

import 'CECDetailsPage.dart';

class CECPage extends StatefulWidget {
  const CECPage({super.key});

  @override
  State<CECPage> createState() => _CECPageState();
}

class _CECPageState extends State<CECPage> {
  // Demo data
  final List<Map<String, String>> cecMembers = [
    {
      'name': 'Yoweri Kaguta Museveni',
      'role': 'Chairman, NRM Party',
      'image': 'assets/drawable/chairman.jpg',
    },
    {
      'name': 'Yoweri Kaguta Museveni',
      'role': 'Chairman, NRM Party',
      'image': 'assets/drawable/chairman.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Central Executive Committee"),
        backgroundColor: Color(0xFFFFD401),
      ),
      body: ListView.builder(
        itemCount: cecMembers.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final member = cecMembers[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CECDetailsPage(member: member),
                ),
              );
            },
            child: Card(
              color: Color(0xFFFFD401),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        member['image']!,
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            member['name']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            member['role']!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Placeholder for details page
