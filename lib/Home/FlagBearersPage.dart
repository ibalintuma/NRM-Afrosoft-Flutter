import 'package:flutter/material.dart';
import '../Utils/Constants.dart';
import '../Utils/Helper.dart';

class CampaignPostersPage extends StatefulWidget {
  const CampaignPostersPage({super.key});

  @override
  State<CampaignPostersPage> createState() => _CampaignPostersPageState();
}

class _CampaignPostersPageState extends State<CampaignPostersPage> {
  bool _loadingPosters = true;
  List<Map<String, dynamic>> _posters = [];

  @override
  void initState() {
    super.initState();
    getCampaignPosters();
  }

  void getCampaignPosters() {
    requestAPI(
      getApiURL("retrieve_campaign_posts.php"),
      {"": ""},
      (loading) {
        setState(() {
          _loadingPosters = loading;
        });
      },
      (response) {
        setState(() {
          _posters = List<Map<String, dynamic>>.from(response);
          _loadingPosters = false;
        });
      },
      (error) {
        setState(() {
          _loadingPosters = false;
        });
      },
      method: "GET",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Campaign Posters',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFD401),
        elevation: 2,
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child:
            _loadingPosters
                ? const Center(
                  child: CircularProgressIndicator(color: Color(0xFFFFD401)),
                )
                : GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 images per row
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: _posters.length,
                  itemBuilder: (context, index) {
                    final poster = _posters[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        getImageURL("CampaignPosters", poster['poster']),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
