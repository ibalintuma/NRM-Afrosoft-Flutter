import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  final String PRIVACY_POLICY_URL =
      "https://docs.google.com/document/d/e/2PACX-1vT2XRV_IUz5vk_UHB1pVHvfqeOD7Jo2Jh_YfkCZVOIibmfIeb8uAhWugwUIBbA92AY9d528PmARZCM6/pub";

  @override
  void initState() {
    super.initState();
    _launchPrivacyPolicy();
  }

  Future<void> _launchPrivacyPolicy() async {
    final Uri url = Uri.parse(PRIVACY_POLICY_URL);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show a minimal loading indicator while redirecting
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(color: const Color(0xFFFFD401)),
      ),
    );
  }
}
