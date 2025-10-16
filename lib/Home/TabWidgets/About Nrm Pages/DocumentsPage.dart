import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  // A helper function to open document URLs
  Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> documents = [
      {
        'title': 'NRM MANIFESTO ',
        'image': 'assets/drawable/manifesto_image.PNG',
        'url': 'https://www.nrm.ug/NRM_Manifesto_2021-2026.pdf',
      },
      {
        'title': 'POLITICAL ROAD MAP',
        'image': 'assets/drawable/road_map.png',
        'url':
            'https://www.scribd.com/document/826367529/The-NRM-Political-Roadmap-2024-2027',
      },
      {
        'title': 'THE LEGACY PUBLICATION',
        'image': 'assets/drawable/legacy.jpg',
        'url': 'https://www.nrm.ug/legacy-publication',
      },
      {
        'title': 'OUR CONSTITUTION',
        'image': 'assets/drawable/nrm_logo.png',
        'url': 'https://www.nrm.ug/node/387',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD401),
        foregroundColor: Colors.black,
        title: const Text(
          'Documents',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children:
              documents.map((doc) {
                return Column(
                  children: [
                    Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 12.0,
                              left: 12,
                              right: 12,
                            ),
                            child: Text(
                              doc['title']!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                doc['image']!,
                                height: 220,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ElevatedButton.icon(
                              onPressed: () => _openUrl(doc['url']!),

                              label: const Text(
                                'View Document',
                                style: TextStyle(
                                  color: const Color(0xFFFFD401),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                minimumSize: const Size(double.infinity, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }).toList(),
        ),
      ),
    );
  }
}
