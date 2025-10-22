import 'package:flutter/material.dart';
import 'package:nrm_afrosoft_flutter/Home/TabWidgets/AskPresidentPage.dart';

import 'CandidatesDetailPage.dart';

class CandidatesPage extends StatefulWidget {
  const CandidatesPage({super.key});

  @override
  State<CandidatesPage> createState() => _CandidatesPageState();
}

class _CandidatesPageState extends State<CandidatesPage> {
  final List<String> _titles = [
    'Presidential Candidate',
    'Members of Parliament',
    'Mayors',
    'LC5s',
    'LC3s',
    'Youth Representatives',
    'People with Disability',
    'LC1s',
    'Other Persons',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NRM Candidates',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFD401),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/drawable/nrm_candidates_bg.jpg',
            fit: BoxFit.cover,
          ),

          // Overlay for visibility
          Container(color: Colors.black.withOpacity(0.5)),

          // Scrollable list
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_titles.length, (index) {
                  final title = _titles[index];
                  return GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        // Presidential candidate page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AskPresidentPage(),
                          ),
                        );
                      } else {
                        // Other candidate pages
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CandidatesDetailPage(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Logo container
                          Image.asset(
                            height: 40,
                            width: 40,
                            'assets/drawable/nrm_logo.png',
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 16),
                          // Title
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          // Forward icon
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
