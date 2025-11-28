import 'package:flutter/material.dart';

class AboutNRMWidget extends StatefulWidget {
  const AboutNRMWidget({super.key});

  @override
  State<AboutNRMWidget> createState() => _AboutNRMWidgetState();
}

class _AboutNRMWidgetState extends State<AboutNRMWidget> {
  final List<Map<String, String>> menuItems = [
    {'title': 'How to Join NRM', 'route': '/joinNRM'},
    {'title': 'About Us', 'route': '/aboutUs'},
    {'title': 'Our Constitution', 'route': '/constitution'},
    {'title': 'Party Structure', 'route': '/partyStructure'},
    {'title': 'Our Documents', 'route': '/documents'},
    {'title': 'Our History', 'route': '/history'},
    {'title': 'NRM Gallery', 'route': '/gallery'},
    {'title': 'Privacy Policy', 'route': '/privacyPolicy'},
    {'title': 'Terms of Use', 'route': '/termsOfUse'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        // Top Image
        Container(
          width: 350,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: AssetImage('assets/drawable/web_logo.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 30),

        // Menu List
        ...menuItems.map(
              (item) => GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, item['route']!);
            },
            child: Container(
              margin: EdgeInsets.only(
                bottom: 12,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 14,
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Dot
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFD401),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Text
                  Expanded(
                    child: Text(
                      item['title']!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFFD401),
                      ),
                    ),
                  ),

                  // Forward icon in colored circle
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFD401),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 30),

        // Bottom Image
        Container(
          width: 350,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: AssetImage('assets/drawable/web_logo.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}