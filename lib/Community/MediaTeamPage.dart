import 'package:flutter/material.dart';
import 'package:nrm_afrosoft_flutter/Community/BloggersPage.dart';

class MediaTeamPage extends StatefulWidget {
  const MediaTeamPage({super.key});

  @override
  State<MediaTeamPage> createState() => _MediaTeamPageState();
}

class _MediaTeamPageState extends State<MediaTeamPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFFFFD401),
        title: const Text("Media Team", style: TextStyle(color: Colors.white)),
        bottom: TabBar(
          dividerColor: Colors.white,
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Color(0xFFFFD401),
          tabs: const [
            Tab(text: "BLOGGERS"),
            Tab(text: "TV STATIONS"),
            Tab(text: "RADIO STATIONS"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          BloggersPage(),
          Center(child: Text("TV Stations content will go here")),
          Center(child: Text("Radio Stations content will go here")),
        ],
      ),
    );
  }
}
