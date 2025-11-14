import 'dart:convert';

import 'package:nrm_afrosoft_flutter/Utils/Helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  // TODO: Replace this with your actual authentication check
  // Example: Check auth state in initState or use a stream/provider
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    // TODO: Initialize and check authentication status here
    _checkAuthStatus();
    _startLoading();
  }

  // Example method to check authentication
   void _checkAuthStatus() async {

     var preferences = await SharedPreferences.getInstance();
     var user = preferences.getString("user") ?? "";
     var _user = jsonDecode(user);

     final authStatus = _user.isNotEmpty;
     setState(() {
       isLoggedIn = authStatus;
     });
   }


   //create a delay that simulates loading
    var loading = true;
  _startLoading() async {
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      loading = false;
    });
  }

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
      body: isLoggedIn
          ? Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Groups Joined', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                if (loading)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: bossBaseLoader(),
                ),
                SizedBox(height: 16),
                Text('Other Groups', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                SizedBox(height: 16),
              ],
            ),
          )
          : Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock_outline,
                size: 80,
                color: Color(0xFFFFD401),
              ),
              const SizedBox(height: 24),
              const Text(
                'Login Required',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'This feature can only be accessed when you are logged in.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}