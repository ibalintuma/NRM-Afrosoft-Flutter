import 'package:flutter/material.dart';
import 'package:nrm_afrosoft_flutter/Home/AIChatPage.dart';

import 'package:url_launcher/url_launcher.dart';

class SupportCenter extends StatefulWidget {
  const SupportCenter({super.key});

  @override
  State<SupportCenter> createState() => _SupportCenterState();
}

class _SupportCenterState extends State<SupportCenter> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message sent successfully!')),
      );

      // You can integrate your API logic here later.
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  Widget _socialItem({
    required String imagePath,
    required String label,
    required Color color,
    required String url,
  }) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Image.asset(imagePath, color: color),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Color(0xFFFFD401),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text(
                  "Contact NRM",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Row(children: [const SizedBox(width: 10)]),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: 250,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(color: Color(0xFFFFD401)),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Text
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: const Text(
                          "Welcome to NRM Support Center",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Horizontally scrollable row of contact options
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap:
                                  () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AIChatPage(),
                                      ),
                                    ),
                                  },
                              child: _supportOption(
                                imagePath:
                                    "assets/drawable/customer_service_icon.png",
                                label: "Ask NRM AI",
                                color: Color(0xFFFFD401),
                              ),
                            ),
                            _supportOption(
                              imagePath:
                                  "assets/drawable/icons8_direct_call_100.png",
                              label: "Call NRM Office",
                              color: Color(0xFFFFD401),
                            ),
                            GestureDetector(
                              onTap:
                                  () => {
                                    _launchURL(
                                      "https://wa.me/256773475844?text=Hello%20NRM%20Support",
                                    ),
                                  },
                              child: _supportOption(
                                imagePath:
                                    "assets/drawable/icons8_whatsapp_chat_100.png",
                                label: "WhatsApp NRM",
                                color: Color(0xFFFFD401),
                              ),
                            ),

                            _supportOption(
                              imagePath:
                                  "assets/drawable/icons8_sms_chat_100.png",
                              label: "SMS NRM",
                              color: Color(0xFFFFD401),
                            ),
                            _supportOption(
                              imagePath:
                                  "assets/drawable/icons8_video_chat_100.png",
                              label: "Video Chat",
                              color: Color(0xFFFFD401),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Helper widget
                SizedBox(height: 10),

                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .center, // Align the content to the left
                    children: [
                      // Title with bottom border
                      IntrinsicWidth(
                        child: Container(
                          alignment:
                              Alignment
                                  .center, // Center the text inside the container
                          padding: const EdgeInsets.only(
                            bottom: 6,
                          ), // Space below the text
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black, // Border color
                                width: 1, // Border thickness
                              ),
                            ),
                          ),
                          child: const Text(
                            "Follow NRM",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ), // Space between title and contact info
                      // Column with Address, Email, and Phone
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row 1
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,

                            children: [
                              _socialItem(
                                imagePath:
                                    'assets/drawable/icons8_youtube_100.png',
                                label: 'YouTube',
                                color: Colors.red,
                                url: 'https://www.youtube.com/@NrmUgOnline',
                              ),
                              const SizedBox(width: 25),
                              _socialItem(
                                imagePath: 'assets/drawable/facebook_white.png',
                                label: 'Facebook',
                                color: Colors.blue,
                                url: 'https://www.facebook.com/NRMPartyUganda/',
                              ),
                              const SizedBox(width: 25),
                              _socialItem(
                                imagePath:
                                    'assets/drawable/icons8_instagram_100.png',
                                label: 'Instagram',
                                color: Colors.deepOrange,
                                url:
                                    'https://www.instagram.com/nrmuganda/?hl=en',
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // Row 2
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _socialItem(
                                imagePath:
                                    'assets/drawable/icons8_twitter_24.png',
                                label: 'Twitter',
                                color: Colors.lightBlue,
                                url:
                                    'https://x.com/NRMOnline?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor',
                              ),
                              const SizedBox(width: 25),
                              _socialItem(
                                imagePath:
                                    'assets/drawable/icons8_flickr_100.png',
                                label: 'Flickr',
                                color: Colors.red,
                                url:
                                    'https://www.flickr.com/photos/nrmonline/page6',
                              ),
                              const SizedBox(width: 25),
                              _socialItem(
                                imagePath:
                                    'assets/drawable/icons8_soundcloud_100.png',
                                label: 'SoundCloud',
                                color: Colors.orange,
                                url: 'https://soundcloud.com/nrm-uganda',
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Row 3
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Row(
                              children: [
                                _socialItem(
                                  imagePath:
                                      'assets/drawable/icons8_tiktok_100.png',
                                  label: 'TikTok',
                                  color: Colors.black,
                                  url:
                                      'https://www.tiktok.com/@nrmpartyuganda?lang=en',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title with bottom border
                      IntrinsicWidth(
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(bottom: 6),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFFFFD401),
                                width: 1,
                              ),
                            ),
                          ),
                          child: const Text(
                            "Send Us an Email",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Send us a Message",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),

                            // Name
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: 'Name',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person_outline),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),

                            // Email
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email Address',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email address';
                                }
                                if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                ).hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),

                            // Message
                            TextFormField(
                              controller: _messageController,
                              decoration: const InputDecoration(
                                labelText: 'Your Message',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.message_outlined),
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: 4,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your message';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Send Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _sendMessage,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFFD401),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'SEND MESSAGE',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _supportOption({
    required String imagePath,
    required String label,
    required Color color,
  }) {
    return Container(
      width: 120,
      height: 120,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFFFD401),
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              imagePath,
              height: 32,
              width: 32,
              color: Colors.black, // optional tint
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
