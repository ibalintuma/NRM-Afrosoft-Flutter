import 'package:flutter/material.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NRM Groups',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFD401),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Center(child: Text('NRM Groups Page Content Here')),
    );
  }
}
