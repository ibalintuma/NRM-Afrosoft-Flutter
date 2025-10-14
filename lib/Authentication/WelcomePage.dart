import 'package:flutter/material.dart';
import 'dart:async';

import 'package:nrm_afrosoft_flutter/Authentication/LoginPage.dart';

import 'RegisterPage.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // ✅ Zoom in/out animation for the IMAGE only
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 1.0,
      end: 1.05, // gentle zoom without leaving container
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _skipToNextPage() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ✅ Background image
          Image.asset('assets/drawable/app_bg_two.png', fit: BoxFit.cover),

          // ✅ Overlay
          Container(color: Colors.black.withOpacity(0.9)),

          // ✅ Foreground content
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // 🔹 Animated zooming IMAGE inside container
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 280, // full-width top section
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      boxShadow: [
                        // 🟡 Thicker yellow glow (top)
                        const BoxShadow(
                          color: Color(0xFFFFF176),
                          offset: Offset(
                            0,
                            -12,
                          ), // slightly stronger upward offset
                          blurRadius: 28, // larger blur for a glowing effect
                          spreadRadius: 6, // more spread for thickness
                        ),

                        // ⚫ Thicker black shadow (bottom)
                        BoxShadow(
                          color: Colors.black.withOpacity(
                            0.75,
                          ), // deeper black tone
                          offset: const Offset(0, 18), // more downward shadow
                          blurRadius: 35, // softer but deeper shadow
                          spreadRadius: 10, // thicker base
                        ),
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _animation.value,
                          child: child,
                        );
                      },
                      child: Image.asset(
                        'assets/drawable/nrm_candidates_bg.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 140),

              // 🔹 NRM Logo
              Image.asset('assets/drawable/nrm_logo.png', height: 80),

              const SizedBox(height: 16),

              // 🔹 App name
              const Text(
                'NRM App',
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              // 🔹 Continue with Email button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    'Continue with Email',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 Divider with "or"
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: const [
                    Expanded(
                      child: Divider(color: Colors.white70, thickness: 1),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'or',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: Colors.white70, thickness: 1),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 Continue with Google button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Text(
                    'G',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.yellow,
                    ),
                  ),
                  label: const Text(
                    'Continue with Google',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:
                          Colors
                              .yellow, // text color contrasts with black background
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // button color
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: const BorderSide(
                        color: Colors.yellow, // border color
                        width: 2, // border thickness
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // 🔹 Terms and Privacy
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Terms and Conditions',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Text(
                      'Privacy Policy',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 Skip button
              TextButton.icon(
                onPressed: _skipToNextPage,
                icon: const Icon(Icons.arrow_forward, color: Colors.yellow),
                label: const Text(
                  'SKIP',
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
