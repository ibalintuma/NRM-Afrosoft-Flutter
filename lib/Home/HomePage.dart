import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nrm_afrosoft_flutter/Community/CommunityPage.dart';
import 'package:nrm_afrosoft_flutter/Home/FlagBearersPage.dart';
import 'package:nrm_afrosoft_flutter/Home/PostPosterPage.dart';
import 'package:nrm_afrosoft_flutter/Home/SupportCenter.dart';
import 'package:nrm_afrosoft_flutter/Home/TabWidgets/About%20Nrm%20Pages/JoinNRMPage.dart';
import 'package:nrm_afrosoft_flutter/Utils/Constants.dart';
import 'package:nrm_afrosoft_flutter/Utils/Helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Authentication/LoginPage.dart';
import 'ProfilePage.dart';
import 'TabWidgets/AboutNRMWidget.dart';
import 'TabWidgets/AchievementsWidget.dart';
import 'TabWidgets/EventsWidget.dart';
import 'TabWidgets/HomeTabWidget.dart';
import 'TabWidgets/LiveTVWidget.dart';
import 'TabWidgets/NewsRoomWidget.dart';
import 'TabWidgets/VideosWidget.dart' show VideosWidget;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool _showImages = true;

  var carouselImages = [];

  int activeIndex = 0;
  late TabController _tabController;

  // Tab labels for TabBar
  final List<String> tabLabels = [
    'HOME',
    'ACHIEVEMENTS',
    'NRM LIVE TV',
    'NRM VIDEOS',
    'NEWS ROOM',
    'EVENTS',
    'ABOUT NRM',
  ];

  // Corresponding tab views (widgets)
  final List<Widget> tabViews = [
    HomeTabWidget(), // Replace with your actual widget
    AchievementsWidget(),
    LiveTVWidget(),
    VideosWidget(),
    NewsRoomWidget(),
    EventsWidget(),
    AboutNRMWidget(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabLabels.length, vsync: this);
    getCampaignPosters();
    getSliderImages();
  }

  var _loadingPosters = false;
  var _posters = [];
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
          _posters = response;
        });
      },
      (error) {},
      method: "GET",
    );
  }
  // bool checkUserLoggedIn() {
  //   // Example: return true if user token exists
  //   return SharedPreferences.getInstance().then((prefs) {
  //     return prefs.containsKey('userToken');
  //   });
  // }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFabMenu(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      // ✅ Fixed AppBar
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD401),
        toolbarHeight: 90,
        titleSpacing: 0,
        title: Row(
          children: [
            // Left side: NRM title
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'NRM',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'National Resistance Movement',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                SizedBox(height: 3),
              ],
            ),
            SizedBox(width: 30),
            // Right side: icons
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // IconButton(
                //   onPressed: () {},
                //   icon: const Icon(Icons.translate, color: Colors.white),
                // ),
                SizedBox(width: 60),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfilePage()),
                    );
                  },
                  icon: const CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage(
                      'assets/drawable/avatar.png',
                    ), // replace with your asset
                  ),
                ),
                // PopupMenuButton<String>(
                //   onSelected: (value) {},
                //   itemBuilder: (BuildContext context) {
                //     return const [
                //       PopupMenuItem(
                //         value: 'Share App',
                //         child: Text('Share App'),
                //       ),
                //       PopupMenuItem(
                //         value: 'Terms of Use',
                //         child: Text('Terms of Use'),
                //       ),
                //       PopupMenuItem(
                //         value: 'Privacy Policy',
                //         child: Text('Privacy Policy'),
                //       ),
                //     ];
                //   },
                //   icon: const Icon(Icons.more_vert, color: Colors.white),
                // ),

                // Profile icon
              ],
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // Carousel Slider
          SliverToBoxAdapter(
            child: SizedBox(
              height: 250,
              child: Stack(
                children: [
                  _loadingSliderImages
                      ? const Center(child: CircularProgressIndicator())
                      : CarouselSlider.builder(
                        itemCount: carouselImages.length,
                        itemBuilder: (context, index, realIndex) {
                          final image = carouselImages[index];
                          return Image.network(
                            image,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          );
                        },
                        options: CarouselOptions(
                          height: double.infinity,
                          viewportFraction: 1.0,
                          autoPlay: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              activeIndex = index;
                            });
                          },
                        ),
                      ),

                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: AnimatedSmoothIndicator(
                        activeIndex: activeIndex,
                        count: carouselImages.length,
                        effect: const WormEffect(
                          dotWidth: 8,
                          dotHeight: 8,
                          activeDotColor: Colors.yellow,
                          dotColor: Colors.white54,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to Join NRM page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const JoinNRMPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: const Color(0xFFFFD401),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: const BorderSide(
                            color: Color(0xFFFFD401),
                            width: 2,
                          ),
                        ),
                      ),
                      child: const Text(
                        'JOIN NRM',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Flag Bearers Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row with title, view all, and dropdown
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "NRM Flag Bearers (${_posters.length})",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              // Navigate to full list of flag bearers
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CampaignPostersPage(),
                                ),
                              );
                            },
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              _showImages
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              color: Colors.blueAccent,
                            ),
                            onPressed: () {
                              setState(() {
                                _showImages = !_showImages;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // ✅ Collapsible horizontal images
                  if (_showImages)
                    SizedBox(
                      height: 100, // adjust as needed
                      child:
                          _loadingPosters
                              ? const Center(child: CircularProgressIndicator())
                              : ListView(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                children:
                                    _posters.map<Widget>((poster) {
                                      return GestureDetector(
                                        onTap: (){
                                          //url to opened poster image
                                          String posterUrl = getImageURL(
                                            "CampaignPosters",
                                            poster['poster'],
                                          );
                                          // Show the poster in a dialog
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              content: Image.network(
                                                posterUrl,
                                                fit: BoxFit.cover,
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.pop(context),
                                                  child: const Text('Close'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.network(
                                              //'assets/drawable/todwong_small.jpg',
                                              getImageURL(
                                                "CampaignPosters",
                                                poster['poster'],
                                              ),
                                              width: 100,
                                              fit: BoxFit.cover,
                                            ),
                                            const SizedBox(width: 8),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                              ),
                    ),

                  const SizedBox(height: 12),

                  // Forwarding in Campaign Poster button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PostPosterPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: const Color(0xFFFFD401),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: const BorderSide(
                          color: Color(0xFFFFD401),
                          width: 2,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Forwarding in Campaign Poster',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Sticky TabBar below AppBar
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: Color(0xFFFFD401),
                unselectedLabelColor: Colors.white,
                indicatorColor: Color(0xFFFFD401),

                tabs: tabLabels.map((label) => Tab(text: label)).toList(),
              ),
            ),
          ),

          // TabBarView content
          /*SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: tabViews, // use widgets here
            ),
          ),*/
          // TabBarView content - This makes the content scrollable
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 1.8, // Adjust as needed
              child: TabBarView(
                controller: _tabController,
                children: tabViews,
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildFabMenu() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // 🟨 Support Center button
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: FloatingActionButton.extended(
              extendedPadding: EdgeInsets.symmetric(horizontal: 19, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: const BorderSide(
                  color: Colors.black, // border color
                  width: 2, // border thickness
                ),
              ),
              heroTag: 'support_center',
              onPressed: () {
                // Navigate to Support Center
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SupportCenter()),
                );
              },
              backgroundColor: Color(0xFFFFD401),
              icon: const Icon(Icons.support_agent, color: Colors.black),
              label: const Text(
                'SUPPORT CENTER',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Spacer(),
          // 🟩 Chat button
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: FloatingActionButton.extended(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: const BorderSide(
                  color: Color(0xFFFFD401), // border color
                  width: 2, // border thickness
                ),
              ),
              heroTag: 'chat',
              onPressed: () {
                // Open chat screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommunityPage()),
                );
              },
              backgroundColor: Colors.black,
              icon: const Icon(Icons.chat, color: Color(0xFFFFD401)),
              label: const Text(
                'CHAT',
                style: TextStyle(
                  color: Color(0xFFFFD401),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  var _loadingSliderImages = false;
  var _sliderImages = [];
  void getSliderImages() {
    requestAPI(
      getApiURL("api/slide_banners"),
      {"": ""},
      (loading) {
        setState(() {
          _loadingSliderImages = loading;
        });
      },
      (response) {
        /*{"data":[{"id":"4","image":"https:\/\/nrm.afrosoftug.com\/banners\/1752491314.jpg","title":null,"created_at":"2025-07-14 11:08:34"},{"id":"11","image":"https:\/\/nrm.afrosoftug.com\/banners\/1755882026.jpg","title":null,"created_at":"2025-08-22 17:00:26"},{"id":"14","image":"https:\/\/nrm.afrosoftug.com\/banners\/1757319742.jpg","title":null,"created_at":"2025-09-08 08:22:22"},{"id":"15","image":"https:\/\/nrm.afrosoftug.com\/banners\/1761978538.jpg","title":null,"created_at":"2025-11-01 06:28:58"},{"id":"16","image":"https:\/\/nrm.afrosoftug.com\/banners\/1762590357.jpg","title":null,"created_at":"2025-11-08 08:25:57"},{"id":"17","image":"https:\/\/nrm.afrosoftug.com\/banners\/1762590430.jpg","title":null,"created_at":"2025-11-08 08:27:10"},{"id":"18","image":"https:\/\/nrm.afrosoftug.com\/banners\/1762590494.jpg","title":null,"created_at":"2025-11-08 08:28:14"},{"id":"19","image":"https:\/\/nrm.afrosoftug.com\/banners\/1762590831.jpg","title":null,"created_at":"2025-11-08 08:33:51"}]}*/
        setState(() {
          _sliderImages = response["data"];
          carouselImages =
              _sliderImages.map<String>((img) => img['image']).toList();
        });
      },
      (error) {},
      method: "GET",
    );
  }
}

// Delegate for sticky tab bar
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: Colors.black, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}
