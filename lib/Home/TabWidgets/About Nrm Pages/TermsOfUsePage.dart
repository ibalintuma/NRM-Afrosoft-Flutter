import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsOfUsePage extends StatefulWidget {
  const TermsOfUsePage({super.key});

  @override
  State<TermsOfUsePage> createState() => _TermsOfUsePageState();
}

class _TermsOfUsePageState extends State<TermsOfUsePage> {
  final String TERMS_AND_CONDITIONS_URL =
      "https://docs.google.com/document/d/e/2PACX-1vSF8uv7LL3MNbx-WCqku6_g4-GG0dV8WiTDwUJoiKCShJwmyNRh7IzXzCPy7qHOoMaaeww9N4KkoOLs/pub";

  @override
  void initState() {
    super.initState();
    _launchTermsOfUse();
  }

  Future<void> _launchTermsOfUse() async {
    final Uri url = Uri.parse(TERMS_AND_CONDITIONS_URL);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(color: const Color(0xFFFFD401)),
      ),
    );
  }
}
