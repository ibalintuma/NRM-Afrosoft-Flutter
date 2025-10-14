import 'package:flutter/material.dart';
import 'package:nrm_afrosoft_flutter/Authentication/LoginPage.dart';
import 'package:nrm_afrosoft_flutter/Home/HomePage.dart';
import 'package:nrm_afrosoft_flutter/Utils/Constants.dart';
import 'package:nrm_afrosoft_flutter/Utils/Helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptedTerms = false;

  var loadingDistricts = false;
  var loadingSignUp = false;
  List<dynamic> districts = [];
  dynamic selectedDistrict;

  @override
  void initState() {
    super.initState();

    // Zoom in/out animation for image
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    //get districts
    getDistricts();
  }

  @override
  void dispose() {
    _controller.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Email validation
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Password validation
  bool _isValidPassword(String password) {
    return password.length >= 6;
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
              _goToLogin();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Validate all fields
  bool _validateFields() {
    // Check username
    if (_usernameController.text.trim().isEmpty) {
      _showErrorDialog('Please enter a username');
      return false;
    }

    if (_usernameController.text.trim().length < 3) {
      _showErrorDialog('Username must be at least 3 characters long');
      return false;
    }

    // Check email
    if (_emailController.text.trim().isEmpty) {
      _showErrorDialog('Please enter an email address');
      return false;
    }

    if (!_isValidEmail(_emailController.text.trim())) {
      _showErrorDialog('Please enter a valid email address');
      return false;
    }

    // Check district
    if (selectedDistrict == null) {
      _showErrorDialog('Please select a district');
      return false;
    }

    // Check password
    if (_passwordController.text.isEmpty) {
      _showErrorDialog('Please enter a password');
      return false;
    }

    if (!_isValidPassword(_passwordController.text)) {
      _showErrorDialog('Password must be at least 6 characters long');
      return false;
    }

    // Check confirm password
    if (_confirmPasswordController.text.isEmpty) {
      _showErrorDialog('Please confirm your password');
      return false;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showErrorDialog('Passwords do not match');
      return false;
    }

    // Check terms acceptance
    if (!_acceptedTerms) {
      _showErrorDialog('Please accept the terms and conditions');
      return false;
    }

    return true;
  }

  void _signUp() {
    // Validate all fields first
    if (!_validateFields()) {
      return;
    }

    // Prepare data
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    String district = selectedDistrict['name'] ?? '';

    var persons = [];
    requestAPI(
      getApiURL("register_user_new.php"),
      {
        "user_name": username,
        "email": email,
        "password": password,
        "district": district,
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
            _showSuccessDialog('Registration successful! Please log in.');
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

  void _goToLogin() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset('assets/drawable/app_bg_two.png', fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.9)),

          Stack(
            clipBehavior: Clip.none,
            children: [
              // Top animated image
              Container(
                width: double.infinity,
                height: 280,
                clipBehavior: Clip.hardEdge,
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

              // Positioned registration container
              Positioned(
                top: 170,
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
                      const SizedBox(height: 16),

                      // Username
                      TextField(
                        controller: _usernameController,
                        enabled: !loadingSignUp,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Email
                      TextField(
                        controller: _emailController,
                        enabled: !loadingSignUp,
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

                      // District / Location Dropdown or Loader
                      loadingDistricts
                          ? Container(
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                          : DropdownButtonFormField<dynamic>(
                        decoration: InputDecoration(
                          labelText: 'District / Location',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon:
                          const Icon(Icons.location_on_outlined),
                        ),
                        items: districts
                            .map((district) => DropdownMenuItem<dynamic>(
                          value: district,
                          child: Text(district['name']),
                        ))
                            .toList(),
                        value: selectedDistrict,
                        onChanged: loadingSignUp
                            ? null
                            : (value) {
                          setState(() {
                            selectedDistrict = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      // Password
                      TextField(
                        controller: _passwordController,
                        enabled: !loadingSignUp,
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
                      const SizedBox(height: 16),

                      // Confirm Password
                      TextField(
                        controller: _confirmPasswordController,
                        enabled: !loadingSignUp,
                        obscureText: _obscureConfirmPassword,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Terms & Privacy links
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Terms & Conditions',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Privacy Policy',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Accept terms checkbox
                      Row(
                        children: [
                          Checkbox(
                            value: _acceptedTerms,
                            onChanged: loadingSignUp
                                ? null
                                : (value) {
                              setState(() {
                                _acceptedTerms = value ?? false;
                              });
                            },
                          ),
                          const Expanded(
                            child: Text(
                              'I accept the terms and conditions',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Sign Up Button with loader
                      ElevatedButton(
                        onPressed:
                        (_acceptedTerms && !loadingSignUp) ? _signUp : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.yellow,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: Colors.yellow),
                          ),
                        ),
                        child: loadingSignUp
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.yellow),
                          ),
                        )
                            : const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Already have an account?
                      const Center(
                        child: Text(
                          'Already have an account?',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Login button
                      Center(
                        child: TextButton(
                          onPressed: loadingSignUp ? null : _goToLogin,
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
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
          if (loadingSignUp)
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
                          'Creating your account...',
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

  //[{id: 1, name: Abim, latitude: 2.7081076, longitude: 33.6511208},
  void getDistricts() {
    requestAPI(
      getApiURL("retrieve_all_districts.php"),
      {"": ""},
          (progress) {
        setState(() {
          loadingDistricts = progress;
        });
      },
          (response) {
        setState(() {
          districts = response;
          if (districts.isNotEmpty) {
            selectedDistrict = districts[0];
          }
        });
      },
          (error) {
        _showErrorDialog('Failed to load districts: $error');
      },
    );
  }
}