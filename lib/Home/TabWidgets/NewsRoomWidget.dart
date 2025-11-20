import 'package:flutter/material.dart';

import '../../Utils/Constants.dart';
import '../../Utils/Helper.dart';

class NewsRoomWidget extends StatefulWidget {
  const NewsRoomWidget({super.key});

  @override
  State<NewsRoomWidget> createState() => _NewsRoomWidgetState();
}

class _NewsRoomWidgetState extends State<NewsRoomWidget> {


  @override
  void initState() {
    super.initState();
    getNews();
  }

  var _loadingNews = false;
  var _news = [];
  void getNews() {
    //requestAPI(getApiURL("retrieve_campaign_posts.php"), {"":""}, (loading){}, (response){}, (error){}, method: "GET");
    requestAPI(getApiURL("retrieve_all_news.php"), {"":""}, (loading){
      setState(() {
        _loadingNews = loading;
      });
    }, (response){
      print("_NEWS");
      setState(() {
        _news = response;
      });
      print(_news);
    }, (error){}, method: "GET");
  }


  @override
  Widget build(BuildContext context) {
    return _loadingNews ? bossBaseLoader() :
          SingleChildScrollView(
            child: Column(
              children: List.generate(_news.length, (index) {
                final news = _news[index];
                return Column(
                  children: [
                    Container(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 8,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side: title, date, and read more
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news["headline"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        formatLaravelTime(news["date"]),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          // TODO: Navigate to details page
                        },
                        child: const Text(
                          "Read more...",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            
                const SizedBox(width: 10),
            
                // Right side: image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    getImageURL("NewsImages", news["image"]),
                    width: 100,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
                    ),
                    if (index != _news.length - 1)
            const Divider(color: Colors.grey, thickness: 0.5),
                  ],
                );
              }),
            ),
          );
  }
}
