import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BloggersPage extends StatefulWidget {
  const BloggersPage({super.key});

  @override
  State<BloggersPage> createState() => _BloggersPageState();
}

class _BloggersPageState extends State<BloggersPage> {
  // Demo data (no image paths per blogger)
  final List<Map<String, dynamic>> bloggers = [
    {'name': 'Allan Hirya', 'location': 'Kampala', 'phone': '+256701234567'},
    {'name': 'Frank Sebuma', 'location': 'Mbarara', 'phone': '+256779876543'},
  ];

  Future<void> openWhatsApp(String phone) async {
    final uri = Uri.parse('https://wa.me/${phone.replaceAll("+", "")}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not open WhatsApp')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: bloggers.length,
      separatorBuilder: (_, __) => const Divider(height: 24),
      itemBuilder: (context, index) {
        final blogger = bloggers[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Blogger logo (same for all)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/drawable/nrm_logo.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),

              // Blogger details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name + Location
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          blogger['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              blogger['location'],
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Phone number
                    Text(
                      'Tel: ${blogger['phone']}',
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Buttons row
                    Row(
                      children: [
                        // WhatsApp Button
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => openWhatsApp(blogger['phone']),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFD401),
                              foregroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Whatsapp',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Follow Button
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFD401),
                              foregroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Follow',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
