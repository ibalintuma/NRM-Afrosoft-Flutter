import 'package:flutter/material.dart';

import '../../../Utils/Constants.dart';
import '../../../Utils/Helper.dart';
import 'LeadersDetailPage.dart';

class LeadersPage extends StatefulWidget {
  const LeadersPage({super.key});

  @override
  State<LeadersPage> createState() => _LeadersPageState();
}

class _LeadersPageState extends State<LeadersPage> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();



  @override
  void initState() {
    super.initState();
    getLeaders();
  }

  var leaderCategories = [];
  var _loaderLeaders = false;
  getLeaders(){
    requestAPI(getApiURL("retrieve_all_leaders.php"), {"":""}, (loader){
      setState(() {
        _loaderLeaders = loader;
      });
    }, (response){
      customLog(response);
      setState(() {
        leaderCategories = response;
      });
    }, (error){
      customLog(error);
    },method: "GET");
  }




  final Map<String, bool> _expandedStates = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFD401),
        title:
            !_isSearching
                ? const Text(
                  "NRM Leaders",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
                : TextField(
                  controller: _searchController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "Search leaders...",
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) _searchController.clear();
              });
            },
          ),
        ],
      ),
      body:
      _loaderLeaders ? Center(child: bossBaseLoader()) :
      ListView.builder(
        itemCount: leaderCategories.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final category = leaderCategories[index];
          final categoryName = category['office'];
          final leaders = category['members'] as List;

          final isExpanded = _expandedStates[categoryName] ?? false;

          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _expandedStates[categoryName] = !isExpanded;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFD401),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/drawable/nrm_logo.png', // your logo asset
                        width: 40,
                        height: 40,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Office:",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          categoryName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),

              // Expanded leaders section
              if (isExpanded)
                Container(
                  margin: const EdgeInsets.only(top: 6, bottom: 12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children:
                        leaders.map((leader) {

                          /*{
I/flutter ( 9113): │ 🐛         "id": "1",
I/flutter ( 9113): │ 🐛         "office_id": "1",
I/flutter ( 9113): │ 🐛         "name": "H.E.YOWERI KAGUTA MUSEVENI",
I/flutter ( 9113): │ 🐛         "position": "Chairman-NRM",
I/flutter ( 9113): │ 🐛         "image": "President_Yoweri_Museveni.jpg",
I/flutter ( 9113): │ 🐛         "about": null
I/flutter ( 9113): │ 🐛       }*/

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => LeadersDetailPage(leader: leader),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 28,
                                    backgroundImage: NetworkImage(
                                      getImageURL("LeaderImages", leader['image'] ?? "..."),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          leader['name'] ?? "...",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          leader['position'] ?? "...",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
