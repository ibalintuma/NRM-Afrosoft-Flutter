import 'package:flutter/material.dart';

import '../../Utils/Constants.dart';
import '../../Utils/Helper.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AchievementsWidget extends StatefulWidget{
  @override
  State<AchievementsWidget> createState() {
    return _AchievementsWidget();
  }

}

class _AchievementsWidget extends State<AchievementsWidget>{

  var _loading_achievements = false;
  var _achievements = [];
  void get_achievements() {
    requestAPI(getApiURL("retrieve_all_achievements.php"), {"":""}, (loading){
      setState(() {
        _loading_achievements = loading;
      });
    }, (response){
      print("__achievements");
      setState(() {
        _achievements = response;
      });
      print(_achievements);
    }, (error){}, method: "GET");
  }

  @override
  void initState() {
    super.initState();
    get_achievements();
  }
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child:
      _loading_achievements ? bossBaseLoader() :
      Column(
        children:
        _achievements.map((achievement) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 20),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      getImageURL("AchievementImages", achievement["image"]),
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Title Text
                  Text(
                    achievement["title"]!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Centered Round Yellow Button
                  Center(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // TODO: Add action here (e.g., open details)
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

