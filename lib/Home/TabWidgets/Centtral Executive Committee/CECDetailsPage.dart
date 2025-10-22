import 'package:flutter/material.dart';

class CECDetailsPage extends StatelessWidget {
  final Map<String, String> member;

  const CECDetailsPage({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(member['role'] ?? 'Role'),
        backgroundColor: Color(0xFFFFD401),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Full width image
            if (member['image'] != null)
              Image.asset(
                member['image']!,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),

            const SizedBox(height: 16),

            // Info card
            Card(
              color: Color(0xFFFFD401),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member['name'] ?? '',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            member['role'] ?? '',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
