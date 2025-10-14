import 'package:flutter/material.dart';
import 'package:nrm_afrosoft_flutter/Authentication/LoginPage.dart';
import 'package:nrm_afrosoft_flutter/Authentication/WelcomePage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ✅ Background image
          Image.asset('assets/drawable/app_bg.png', fit: BoxFit.cover),

          Container(color: Colors.yellow.withOpacity(0.4)),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20), // ✅ Curved corners
                    image: const DecorationImage(
                      image: AssetImage('assets/drawable/ic_nrm_app_icon.png'),
                      fit: BoxFit.contain,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ], // ✅ Optional soft shadow for better look
                  ),
                ),

                const SizedBox(height: 20),

                // "NRM"
                const Text(
                  'NRM',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 8),

                // "National Resistance Movement"
                const Text(
                  'National Resistance Movement',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
