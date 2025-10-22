import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RDCsPage extends StatefulWidget {
  const RDCsPage({super.key});

  @override
  State<RDCsPage> createState() => _RDCsPageState();
}

class _RDCsPageState extends State<RDCsPage> {
  String _activeCategory = 'RDC';
  final TextEditingController _searchController = TextEditingController();

  // Demo data
  final List<Map<String, String>> demoData = [
    {
      'name': 'John Doe',
      'title': 'RDC',
      'station': 'Kampala',
      'telephone': '+256701234567',
    },
    {
      'name': 'Jane Smith',
      'title': 'RDC',
      'station': 'Gulu',
      'telephone': '+256701234568',
    },
    {
      'name': 'Peter Okello',
      'title': 'DRDC',
      'station': 'Mbale',
      'telephone': '+256701234569',
    },
    {
      'name': 'Grace Namanya',
      'title': 'DRDC',
      'station': 'Mbarara',
      'telephone': '+256701234570',
    },
  ];

  Future<void> _launchPhone(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Cannot launch phone app')));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter data based on active category
    List<Map<String, String>> filteredData =
        demoData
            .where(
              (e) =>
                  e['title'] == _activeCategory &&
                  (e['name']!.toLowerCase().contains(
                        _searchController.text.toLowerCase(),
                      ) ||
                      e['station']!.toLowerCase().contains(
                        _searchController.text.toLowerCase(),
                      )),
            )
            .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('RDCs & DRDCs'),
        backgroundColor: Color(0xFFFFD401),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Search Field
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by station or name',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (_) {
                setState(() {}); // refresh filtered data
              },
            ),

            const SizedBox(height: 12),

            // Category Tabs
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _categoryButton('RDC'),
                const SizedBox(width: 12),
                _categoryButton('DRDC'),
              ],
            ),

            const SizedBox(height: 12),

            // List of people
            Expanded(
              child: ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  final person = filteredData[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(
                            0,
                            3,
                          ), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 100, // container width
                          height: 100, // container height
                          padding: const EdgeInsets.all(
                            4,
                          ), // optional padding inside
                          decoration: BoxDecoration(
                            color: Color.fromARGB(
                              255,
                              94,
                              128,
                              186,
                            ), // optional background color
                            // rounded corners
                          ),
                          child: Image.asset(
                            'assets/drawable/nrm_logo.png',
                            width: 40,
                            height: 40,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                person['name']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Title: ${person['title']!}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Station: ${person['station']!}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Tel: ${person['telephone']!}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 90,
                          width: 1,
                          color: Color.fromARGB(255, 94, 128, 186),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.phone,
                            color: Color.fromARGB(255, 94, 128, 186),
                          ),
                          onPressed: () => _launchPhone(person['telephone']!),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Category button widget
  Widget _categoryButton(String title) {
    bool isActive = _activeCategory == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeCategory = title;
        });
      },
      child: Container(
        width: 150,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color:
              isActive ? Color(0xFFFFD401) : Color.fromARGB(255, 94, 128, 186),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
