import 'package:flutter/material.dart';
import 'package:nrm_afrosoft_flutter/Authentication/RegisterPage.dart';
import 'package:nrm_afrosoft_flutter/Home/HomePage.dart';
import 'package:nrm_afrosoft_flutter/Utils/Constants.dart';
import 'package:nrm_afrosoft_flutter/Utils/Helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _obscurePassword = true; // for password visibility
  bool _isLoggingIn = false; // for loading state

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // ✅ Zoom in/out animation for IMAGE only
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Email validation
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Error'),
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
              _navigateToHome();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Navigate to home page
  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  // Validate fields
  bool _validateFields() {
    // Check email
    if (_emailController.text.trim().isEmpty) {
      _showErrorDialog('Please enter your email address');
      return false;
    }

    if (!_isValidEmail(_emailController.text.trim())) {
      _showErrorDialog('Please enter a valid email address');
      return false;
    }

    // Check password
    if (_passwordController.text.isEmpty) {
      _showErrorDialog('Please enter your password');
      return false;
    }

    if (_passwordController.text.length < 6) {
      _showErrorDialog('Password must be at least 6 characters long');
      return false;
    }

    return true;
  }

  void _login() {
    // Validate fields first
    if (!_validateFields()) {
      return;
    }

    // Prepare data
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    var persons = [];
    requestAPI(
      getApiURL("user_login.php"),
      {
        "email": email,
        "password": password,
      },
          (progress) {
        setState(() {
          _isLoggingIn = progress;
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
                _showSuccessDialog('Registration successful! Please log in.');
              } else {
                _showErrorDialog('Registration failed.');
              }
            } else {
              _showErrorDialog('Registration failed. Please try again.');
            }
      },
          (error) {
        setState(() {
          _isLoggingIn = false;
        });
        _showErrorDialog('An error occurred: $error');
      },
    );
  }

  void _forgotPassword() {
    Navigator.pushNamed(context, '/forgot-password'); // update route
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background
          Image.asset('assets/drawable/app_bg_two.png', fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.9)),

          // Foreground
          Stack(
            clipBehavior: Clip.none, // allow overflow
            children: [
              // Top zooming image
              Container(
                width: double.infinity,
                height: 280,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  boxShadow: [
                    const BoxShadow(
                      color: Color(0xFFFFF176),
                      offset: Offset(0, -12),
                      blurRadius: 28,
                      spreadRadius: 6,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.75),
                      offset: const Offset(0, 18),
                      blurRadius: 35,
                      spreadRadius: 10,
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

              // Positioned login container
              Positioned(
                top: 220, // negative or smaller value than image height for overlap
                left: 24,
                right: 24,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Logo
                      Image.asset('assets/drawable/nrm_logo.png', height: 80),
                      const SizedBox(height: 18),

                      // Email
                      TextField(
                        controller: _emailController,
                        enabled: !_isLoggingIn,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Password
                      TextField(
                        controller: _passwordController,
                        enabled: !_isLoggingIn,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _isLoggingIn ? null : _forgotPassword,
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Login Button with loader
                      ElevatedButton(
                        onPressed: _isLoggingIn ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: _isLoggingIn
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white),
                          ),
                        )
                            : const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // I have no account
                      const Center(
                        child: Text(
                          'I have no account?',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Sign Up
                      Center(
                        child: TextButton(
                          onPressed: _isLoggingIn
                              ? null
                              : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Full-screen loader overlay
          if (_isLoggingIn)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text(
                          'Logging in...',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}