import 'package:flutter/material.dart';
import 'dart:async';

import 'package:nrm_afrosoft_flutter/Authentication/LoginPage.dart';
import 'package:nrm_afrosoft_flutter/Home/HomePage.dart';
import 'package:nrm_afrosoft_flutter/Home/TabWidgets/About%20Nrm%20Pages/PrivacyPolicyPage.dart';
import 'package:nrm_afrosoft_flutter/Home/TabWidgets/About%20Nrm%20Pages/TermsOfUsePage.dart';
import 'package:nrm_afrosoft_flutter/Utils/Helper.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/Constants.dart';
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  Future<void> _handleAppleSignIn() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      print('🍎 Apple Sign In Credential:');
      print('User Identifier: ${credential.userIdentifier}');
      print('Email: ${credential.email}');
      print('Given Name: ${credential.givenName}');
      print('Family Name: ${credential.familyName}');
      print('Identity Token: ${credential.identityToken}');
      print('Authorization Code: ${credential.authorizationCode}');

      final preferences = await SharedPreferences.getInstance();

      // ✅ IMPORTANT: Store the user identifier (always available)
      await preferences.setString('apple_user_id', credential?.userIdentifier ?? "");

      // ✅ Only update email and name if they are provided (first time only)
      if (credential.email != null && credential.email!.isNotEmpty) {
        await preferences.setString('apple_email', credential.email!);
        print('✅ Stored new email: ${credential.email}');
      }

      if (credential.givenName != null || credential.familyName != null) {
        final fullName = '${credential.givenName ?? ''} ${credential.familyName ?? ''}'.trim();
        if (fullName.isNotEmpty) {
          await preferences.setString('apple_full_name', fullName);
          print('✅ Stored new full name: $fullName');
        }
      }

      // ✅ Retrieve stored data (will use previously stored data if current sign-in doesn't provide it)
      var storedEmail = preferences.getString('apple_email') ?? '';
      final storedFullName = preferences.getString('apple_full_name') ?? '';
      final storedUserId = preferences.getString('apple_user_id') ?? '';

      print('📱 Stored User Data:');
      print('Email: $storedEmail');
      print('Full Name: $storedFullName');
      print('User ID: $storedUserId');

      if (storedEmail.isEmpty) {
        // ⚠️ No email available - this shouldn't happen on first sign-in
        // but can happen if user previously signed in and you didn't store it
        /*_showErrorDialog(
          //'Email Not Available',
          'Apple did not provide an email address. This usually happens after the first sign-in. Please sign out of Apple ID in Settings and try again, or use email login.',
        );*/
        storedEmail = storedUserId;
        //return;
      }

      // ✅ TODO: Send identityToken to your backend for verification
      // Your backend should:
      // 1. Verify the identityToken with Apple's servers
      // 2. Extract the user's email from the token (it's in the JWT)
      // 3. Create or login the user
      //
      // Example backend call:
      // await _authenticateWithBackend(
      //   identityToken: credential.identityToken,
      //   userIdentifier: credential.userIdentifier,
      // );

      // ✅ For now, navigate to home page (replace with your actual navigation logic)
      social_signUp( storedFullName, storedEmail);

      /*if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()),);
      }*/

    } on SignInWithAppleAuthorizationException catch (e) {
      print('❌ Apple Sign In Authorization Error: ${e.code} - ${e.message}');

      if (e.code == AuthorizationErrorCode.canceled) {
        // User canceled - do nothing
        return;
      }

      _showErrorDialog(
        //'Sign In Failed',
        'Could not sign in with Apple: ${e.message}',
      );
    } catch (e) {
      print('❌ Apple Sign In Error: $e');
      _showErrorDialog(
        //'Sign In Error',
        'An unexpected error occurred. Please try again.',
      );
    }
  }


  var loadingSignUp = false;
  void social_signUp( String username, String email) {


    var persons = [];
    requestAPI(
      getApiURL("user_social_login.php"),
      {
        "user_name": username,
        "email": email,
        "firebase_token": "", //leave empty for now
      },
          (progress) {
        setState(() {
          loadingSignUp = progress;
        });
      },
          (response) {
        print(response); //[{id: 9534, user_name: ibalintuma, picture: , email: ibalintuma1@gmail.com, district: Bundibugyo, password: 1234567890, firebase_token: , notification_id: null}]
        // Check if registration was successful
        if (response != null) {
          persons = response;
          if ( persons.isNotEmpty){
            var person = persons.first;
            savePersonInPreference(person);

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()),);

          } else {
            _showErrorDialog('Registration failed.');
          }
        } else {
          _showErrorDialog('Registration failed. Please try again.');
        }
      }, (error) {
      _showErrorDialog('An error occurred: $error');
    },
    );
  }

  // Show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Validation Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Show success dialog
  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              //_goToLogin();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()),);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
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

              const SizedBox(height: 40),

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
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

              // 🔹 Continue with Apple button

              if( loadingSignUp )
                Center(child: bossBaseLoader(),)
              else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ElevatedButton.icon(
                  onPressed: _handleAppleSignIn,
                  icon: const Icon(
                    Icons.apple,
                    color: Colors.yellow,
                    size: 24,
                  ),
                  label: const Text(
                    'Continue with Apple',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.yellow,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: const BorderSide(
                        color: Colors.yellow,
                        width: 2,
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
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const TermsOfUsePage(),
                          ),
                        );
                      },
                      child: Text(
                        'Terms and Conditions',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PrivacyPolicyPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
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