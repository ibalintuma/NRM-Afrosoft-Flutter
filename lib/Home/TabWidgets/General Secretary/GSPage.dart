import 'package:flutter/material.dart';
import 'package:nrm_afrosoft_flutter/Home/TabWidgets/General%20Secretary/GSQuestionsPage.dart';
import 'package:url_launcher/url_launcher.dart';

class GSPage extends StatefulWidget {
  const GSPage({super.key});

  @override
  State<GSPage> createState() => _GSPageState();
}

class _GSPageState extends State<GSPage> {
  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 450,
            pinned: true,
            stretch: true,

            foregroundColor: Colors.black87,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/drawable/todwong_update.jpg',
                      width: double.infinity,

                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned(
                    bottom: -1,
                    right: 5,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle "ASK THE PRESIDENT" action
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GSQuestionsPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          94,
                          128,
                          186,
                        ),
                        foregroundColor: const Color(0xFFFFD401),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'QUESTIONS AND ANSWERS',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // YouTube video

                  // Headings
                  const Text(
                    'Richard Todwong',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'MRM Secretary General',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Divider(
                    color: Color.fromARGB(255, 94, 128, 186),
                    thickness: 2,
                  ),
                  const SizedBox(height: 12),

                  // Text content
                  const Text('''Richard Todwong is a Ugandan born on 24 November 1973 and raised in Anaka, Nwoya District. Currently serving as the Secretary-General (SG) of the National Resistance Movement (NRM) and executive team leader of the secretariat. He holds a bachelor’s degree in political science and Economics and degree of Master of Arts in International Relations (M.A.Int.Rel.) from Makerere University.''', style: TextStyle(fontSize: 16, height: 1.5), textAlign: TextAlign.justify,),
                  SizedBox(height: 10),
                  const Text('''He has also formerly served as the Deputy SG from 2015 to 2021 and as the Minister Without Portfolio in the Ugandan Cabinet in 2012. Richard was also elected as a Member of Parliament for Nwoya County, Nwoya District.''', style: TextStyle(fontSize: 16, height: 1.5), textAlign: TextAlign.justify,),
                  const SizedBox(height: 16),
                  Text('''With the above educational background, Richard’s career has evolved with time. For over six years, Richard worked as an economist in 1999 with the Uganda Revenue Authority and the Ministry of Justice and Constitutional Affairs. Where he later upgraded into serving in governance positions for over five years since 2006 as a Special Advisor to the President of Uganda attached to Northern Uganda among others. He is passionate about community development; he is also a seasoned community organiser and a social diplomat. ''', style: TextStyle(fontSize: 16, height: 1.5), textAlign: TextAlign.justify,),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Born',
                              style: TextStyle(
                                fontSize: 14,

                                height: 1.5,
                                color: Color.fromARGB(255, 94, 128, 186),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'November 24, 1973, Anaka',
                              style: TextStyle(fontSize: 16, height: 1.5),
                            ),
                            SizedBox(height: 12),

                            Text(
                              'Education',
                              style: TextStyle(
                                fontSize: 14,

                                height: 1.5,
                                color: Color.fromARGB(255, 94, 128, 186),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Makerere University',
                              style: TextStyle(fontSize: 16, height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: const Text(
                      'Follow the General Secretary',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Divider(
                    color: Color.fromARGB(255, 94, 128, 186),
                    thickness: 2,
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

                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
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
