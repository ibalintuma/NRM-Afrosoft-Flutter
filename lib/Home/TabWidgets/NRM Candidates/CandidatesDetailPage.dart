import 'package:flutter/material.dart';

class CandidatesDetailPage extends StatefulWidget {
  const CandidatesDetailPage({super.key});

  @override
  State<CandidatesDetailPage> createState() => _CandidatesDetailPageState();
}

class _CandidatesDetailPageState extends State<CandidatesDetailPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _districts = ['Kampala', 'Mbarara', 'Gulu', 'Jinja'];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Filter districts based on search query
    final filteredDistricts =
        _districts
            .where(
              (district) =>
                  district.toLowerCase().contains(_searchQuery.toLowerCase()),
            )
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select District',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFD401),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search field
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search district',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
          ),

          // Districts list
          Expanded(
            child: ListView.builder(
              itemCount: filteredDistricts.length,
              itemBuilder: (context, index) {
                final district = filteredDistricts[index];
                return GestureDetector(
                  onTap: () {
                    // TODO: Navigate to district details or candidates list
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Selected $district')),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: const Color(0xFFFFD401),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            district,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
