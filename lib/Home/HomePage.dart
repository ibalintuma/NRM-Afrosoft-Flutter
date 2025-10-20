import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nrm_afrosoft_flutter/Community/CommunityPage.dart';
import 'package:nrm_afrosoft_flutter/Home/SupportCenter.dart';
import 'package:nrm_afrosoft_flutter/Utils/Constants.dart';
import 'package:nrm_afrosoft_flutter/Utils/Helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.translate, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.support_agent, color: Colors.white),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {},
                    itemBuilder: (BuildContext context) {
                      return const [
                        PopupMenuItem(
                          value: 'option1',
                          child: Text('Option 1'),
                        ),
                        PopupMenuItem(
                          value: 'option2',
                          child: Text('Option 2'),
                        ),
                      ];
                    },
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
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
                      onPressed: () {},
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
                            onPressed: () {},
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
                                      return Row(
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
                                      );
                                    }).toList(),
                              ),
                    ),

                  const SizedBox(height: 12),

                  // Forwarding in Campaign Poster button
                  ElevatedButton(
                    onPressed: () {},
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
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: tabViews, // use widgets here
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFabMenu() {
    return Row(
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
        const SizedBox(width: 110),
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
