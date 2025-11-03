import 'package:flutter/material.dart';
import 'package:nrm_afrosoft_flutter/Utils/Helper.dart';

import '../../../Utils/Constants.dart';
import 'CECDetailsPage.dart';

class CECPage extends StatefulWidget {
  const CECPage({super.key});

  @override
  State<CECPage> createState() => _CECPageState();
}

class _CECPageState extends State<CECPage> {
  // Demo data
  var cecMembers = [];

  
  @override
  void initState() {
    super.initState();
    getCec();
  }

  var _loaderCec = false;
  getCec(){
    requestAPI(getApiURL("api/executive_committee_members"), {"":""}, (loader){
      setState(() {
        _loaderCec = loader;
      });
    }, (response){
      customLog(response);
      setState(() {
        cecMembers = response["data"];
      });
    }, (error){
      customLog(error);
    },method: "GET");
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Central Executive Committee"),
        backgroundColor: Color(0xFFFFD401),
      ),
      body: _loaderCec ? Center(child: bossBaseLoader()) : ListView.builder(
        itemCount: cecMembers.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final member = cecMembers[index];
          /*{
I/flutter ( 9113): │ 🐛       "id": 12,
I/flutter ( 9113): │ 🐛       "name": "Hon Katongole Singh",
I/flutter ( 9113): │ 🐛       "position": "Hon. Uhuru Salim Nsubuga Vice Chairperson - Kampala",
I/flutter ( 9113): │ 🐛       "image": "https://nrm.afrosoftug.com/LeaderImages/cec_1756737431.jpg",
I/flutter ( 9113): │ 🐛       "about": null,
I/flutter ( 9113): │ 🐛       "created_at": "2025-08-12 09:16:47"
I/flutter ( 9113): │ 🐛     },*/
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
                      child: Image.network(
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
                            member['position']!,
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
