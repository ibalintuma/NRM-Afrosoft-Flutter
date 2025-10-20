import 'package:flutter/material.dart';
import 'package:nrm_afrosoft_flutter/Home/TabWidgets/About%20Nrm%20Pages/JoinNRMForm.dart';
import 'Authentication/SplashPage.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_inappwebview_android/flutter_inappwebview_android.dart';

import 'Home/TabWidgets/About Nrm Pages/AboutUsPage.dart';
import 'Home/TabWidgets/About Nrm Pages/ConstitutionPage.dart';
import 'Home/TabWidgets/About Nrm Pages/DocumentsPage.dart';
import 'Home/TabWidgets/About Nrm Pages/GalleryPage.dart';
import 'Home/TabWidgets/About Nrm Pages/HistoryPage.dart';
import 'Home/TabWidgets/About Nrm Pages/JoinNRMPage.dart';
import 'Home/TabWidgets/About Nrm Pages/PartyStructurePage.dart';
import 'Home/TabWidgets/About Nrm Pages/PrivacyPolicyPage.dart';
import 'Home/TabWidgets/About Nrm Pages/TermsOfUsePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  InAppWebViewPlatform.instance = AndroidInAppWebViewPlatform();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/joinNRMForm': (context) => const JoinNRMForm(),
        '/joinNRM': (context) => const JoinNRMPage(),
        '/aboutUs': (context) => const AboutUsPage(),
        '/constitution': (context) => ConstitutionPage(),
        '/partyStructure': (context) => const PartyStructurePage(),
        '/documents': (context) => DocumentsPage(),
        '/history': (context) => const HistoryPage(),
        '/gallery': (context) => const GalleryPage(),
        '/privacyPolicy': (context) => const PrivacyPolicyPage(),
        '/termsOfUse': (context) => const TermsOfUsePage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'NRM Party App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}
