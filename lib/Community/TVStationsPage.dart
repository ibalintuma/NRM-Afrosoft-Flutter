import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Utils/Constants.dart';
import '../Utils/Helper.dart';

class TVStationDetailPage extends StatelessWidget {
  final Map<String, dynamic> station;

  const TVStationDetailPage({super.key, required this.station});

  // Optional: helper to launch email, phone or URL
  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    const sectionSpacing = SizedBox(height: 16);
    const lineHeight = 3.0;
    const lineColor = Colors.green;

    return Scaffold(
      appBar: AppBar(
        title: Text(station['name'], style: TextStyle(color: Colors.black)),
        backgroundColor: Color(0xFFFFD401),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Station image
            Center(
              child: Image.network(
                getImageURL("MediaImages", station['logo']),
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),

            sectionSpacing,

            // About Station Container
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 94, 128, 186),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About Station',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: lineHeight,
                    width: 300,
                    color: Color(0xFFFFD401),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    station['about'],
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),

            sectionSpacing,

            // Station Contacts Container
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 94, 128, 186),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Station Contacts',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: lineHeight,
                    width: 300,
                    color: Color(0xFFFFD401),
                  ),
                  const SizedBox(height: 12),

                  // Email
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.email,
                          color: Color(0xFFFFD401),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        station['email_address'],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Phone
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.phone,
                          color: Color(0xFFFFD401),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        station['contact'],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Address
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.location_on,
                          color: Color(0xFFFFD401),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          station['address'],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            sectionSpacing,

            // Follow Station On
            Center(
              child: const Text(
                'Follow Station On',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: 380,
              height: 8,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 94, 128, 186),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),

            // Placeholder for social media buttons (can replace with icons)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialItem(
                  imagePath: 'assets/drawable/icons8_youtube_100.png',
                  label: 'YouTube',
                  color: Colors.red,
                  url: 'https://www.youtube.com/@NrmUgOnline',
                ),
                const SizedBox(width: 25),
                _socialItem(
                  imagePath: 'assets/drawable/facebook_white.png',
                  label: 'Facebook',
                  color: Colors.blue,
                  url: 'https://www.facebook.com/NRMPartyUganda/',
                ),
                const SizedBox(width: 25),
                _socialItem(
                  imagePath: 'assets/drawable/icons8_instagram_100.png',
                  label: 'Instagram',
                  color: Colors.deepOrange,
                  url: 'https://www.instagram.com/nrmuganda/?hl=en',
                ),
                const SizedBox(width: 25),
                _socialItem(
                  imagePath: 'assets/drawable/icons8_twitter_24.png',
                  label: 'Twitter',
                  color: Colors.lightBlue,
                  url:
                      'https://x.com/NRMOnline?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialItem({
    required String imagePath,
    required String label,
    required Color color,
    required String url,
  }) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Image.asset(imagePath, color: color),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

// TVStations tab (no Scaffold)
class TVStations extends StatefulWidget {
  const TVStations({super.key});

  @override
  State<TVStations> createState() => _TVStationsState();
}

class _TVStationsState extends State<TVStations> {





  @override
  void initState() {
    super.initState();
    getStation();

  }


  var _loadingStation = false;
  var _stations = [];
  void getStation() {
    requestAPI(
      getApiURL("retrieve_media_stations.php"),
      {"station_id": "3"},
          (loading) {
        setState(() {
          _loadingStation = loading;
        });
      }, (response) {
        setState(() {
          _stations = response;
        });
      },
          (error) {},
      method: "POST",
    );
  }












  @override
  Widget build(BuildContext context) {
    return
      _loadingStation ? Center(child: bossBaseLoader()) :GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: _stations.length,
      itemBuilder: (context, index) {
        final station = _stations[index];
        customLog(station);

        return GestureDetector(
          onTap: () {
            customLog(station);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TVStationDetailPage(station: station),
              ),
            );
          },
          child: Container(
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
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Image.network( getImageURL("MediaImages", station['logo']) , fit: BoxFit.contain),
              ),
            ),
          ),
        );
      },
    );
  }
}
