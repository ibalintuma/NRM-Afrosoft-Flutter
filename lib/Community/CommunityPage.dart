import 'package:flutter/material.dart';
import 'package:nrm_afrosoft_flutter/Community/GroupsPage.dart';
import 'package:nrm_afrosoft_flutter/Community/MediaTeamPage.dart';
import 'package:nrm_afrosoft_flutter/Community/PostsPage.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    // Each page has its own AppBar
    PostPage(),
    GroupsPage(),
    MediaTeamPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Color(0xFFFFD401),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_3_outlined),
            label: 'Community',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'NRM Groups'),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_camera_back),
            label: 'Media Team',
          ),
        ],
      ),
    );
  }
}
