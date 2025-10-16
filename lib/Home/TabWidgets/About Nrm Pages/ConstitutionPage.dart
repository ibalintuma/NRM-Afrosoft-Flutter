import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ConstitutionPage extends StatelessWidget {
  ConstitutionPage({super.key});

  final Uri url = Uri.parse('https://www.nrm.ug/node/387');

  // Corrected URL launcher method
  void _openUrl() async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFD401),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD401),
        foregroundColor: Colors.black,
        title: const Text(
          'Our Constitution',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top card
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  color: Colors.white,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'CONSTITUTION OF THE NATIONAL RESISTANCE MOVEMENT (NRM) AS AMENDED IN JUNE 2010',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ElevatedButton.icon(
                onPressed: _openUrl,
                icon: const Icon(Icons.arrow_forward, color: Color(0xFFFFD401)),
                label: const Text(
                  'READ FULL DOCUMENT',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFFD401),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                    side: const BorderSide(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Preamble card
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  margin: EdgeInsets.zero,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(height: 8),
                        Text(
                          'PREAMBLE:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('''
Whereas the National Resistance Movement was founded as a Liberation Movement and waged a successful protracted people's struggle that liberated Uganda from fascist and dictatorial regimes;

Whereas the National Resistance Movement restored political stability, respect for human rights, national unity, peace, security, law and order, Constitutionalism and rule of law;

Whereas the National Resistance Movement launched and executed a minimum economic recovery programme through rehabilitation and development of socio-economic infrastructure, reduction and privatization of inflation, promotion of local and foreign investment, promotion of private sector led growth and export oriented production;

Whereas the National Resistance Movement introduced democracy and enfranchised the people of Uganda through restoration of the vote of regular, free and fair elections;

Whereas the National Resistance Movement politically empowered previously marginalized sections of our society, namely women, youth, elders, people with disabilities and workers to play their rightful role in management of public affairs;

Whereas the National Resistance Movement established participatory democracy through a policy of decentralization and self-governance through local councils, leading to political empowerment of people and social harmony;

Whereas the National Resistance Movement established and operated the Movement Political System, that enhanced the people's participation in the political, social and economic development of the country;

Whereas the National Resistance Movement restored cultural institutions and pursued a policy of reconciliation; and Aware that the Movement. form of governance is the best system for. pre-industrial society like Uganda

Further Aware. of the Resolutions of the National Conference of the Movement adopted on the 31st day of March 2003 at Uganda International Conference Center, Kampala

Cognisant of the vision, mission, principles and programmes of the National Resistance Movement as a Liberation Movement; and Committed to the advancement of the vision, mission, principles and programmes of the National Resistance Movement as a Liberation Movement
''', style: TextStyle(color: Colors.black, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
