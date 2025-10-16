import 'package:flutter/material.dart';
import 'package:nrm_afrosoft_flutter/Home/TabWidgets/About%20Nrm%20Pages/JoinNRMForm.dart';

class JoinNRMPage extends StatelessWidget {
  const JoinNRMPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFabMenu(context),
      backgroundColor: Color(0xFFFFD401),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD401),
        foregroundColor: Colors.black,
        title: Text(
          'How to Join NRM',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ), // empty title
        actions: [
          TextButton(
            onPressed: () {
              // Add any action here if needed
              Navigator.pushNamed(context, '/joinNRMForm');
            },
            child: const Text(
              'JOIN NRM',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top image card
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
                  child: Image.asset(
                    'assets/drawable/web_logo.png', // replace with your asset
                    fit: BoxFit.contain,
                    height: 90,
                    width: double.infinity,
                  ),
                ),
                Container(
                  width: 380,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Who can join NRM
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
                        Text(
                          'Who can join NRM',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '''Membership to NRM is open to all Ugandans, irrespective of ethnic identity, sex, tribe, creed or religion, birth, economic status, race and disability or other sectional division, who are prepared to abide by its Constitution, Code of Conduct, Rules, Regulations and Bye-laws as may from time to time be made.''',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 380,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // How to Join NRM
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
                        Text(
                          'How to Join NRM',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '''Contact the secretary to your nearest Cell (village) or any other Branch Executive Committee member for registration, upon completion of registration an oath of allegiance to NRM will be made and then a membership card issued.''',
                        ),
                        SizedBox(height: 8),
                        Text(
                          '''
 Membership shall cease if a member:''',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '''
1. Dies;
                
2. Resigns;
                
3. Joins another political organisation or political party;
                
4. Is dismissed in accordance with the Constitution and the Code of Conduct of NRM;
                
5. Is found in breach of the code and in particular;
                
6. Campaigning for a candidate sponsored by another political organisation or party;
                
7. Offering material support to a candidate sponsored by another political organisation or party;
                
8. Campaigning against the official candidate of NRM.
                
9. Dismissal under circumstance (e) above shall be after a fair hearing.

A person who wishes to rejoin NRM may apply in accordance with the Rules and Regulations made under the NRM constitution.''',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 380,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Rights and Duties Card with bottom blue extension
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
                        Text(
                          'Rights and Duties of Members',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Every member of NRM shall have a right to:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '''Rights:
1. Take a full and active part in the discussion, formulation and implementation of policies of NRM at the organ where he/she belongs;

2. Attend meetings of the relevant organ where he/she is a member;

3. Receive and disseminate information on all aspects of NRM policies and activities;

4. Offer constructive criticism of any member, official, policy, programme or activity within the organs of NRM;

5. Take part in elections and be eligible for election to any elective office within the structures of NRM or appointment to any committee, structure, commission or delegation of NRM;

6. Submit proposals or statements to the National Conference, or the National Executive Council (NEC) provided such proposals or statements are submitted through the appropriate structures.

Duties:

1. Belong to and take an active part in the activities of his or her branch;

2. Take all the necessary steps and means to understand and carry out the aims, policies and programmes of NRM;

3. Explain the aims, policies, programmes and achievements of NRM to the population;

4. Fight propaganda detrimental to the interests of NRM and defend its policies, aims and programmes;

5. Guard against sectarianism, tribal chauvinism, sexism, religious and political intolerance or any other form of discrimination;

6. Promote peace, unity and solidarity;

7. Observe discipline, behave honestly and be loyal to the decisions of the majority of the members of the organ where a member belongs and to the decisions of higher organs within the structures of NRM;

8. Refrain from publishing, distributing or making statements to any media house which purports to be the view or position of NRM without authorisation of the organ of NRM where the member belongs;

9. To adhere to the principle that the interests of NRM stand above everything else, subordinating his or her personal interests to the interests of NRM and the nation;

10. Not to engage in any form of corruption and to pursue the eradication of corruption from our society;

11. To mobilise for recruitment of members into NRM;

12. To participate in any activity for purposes of attainment of the objectives and vision of NRM.''',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                // Blue extension at bottom
                Container(
                  width: 380,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFabMenu(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // 🟨 Support Center button

        // 🟩 Chat button
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: FloatingActionButton.extended(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: const BorderSide(
                color: Color(0xFFFFD401), // border color
                width: 2, // border thickness
              ),
            ),
            heroTag: 'chat',
            onPressed: () {
              // Open chat screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JoinNRMForm()),
              );
            },
            backgroundColor: Colors.black,
            icon: const Icon(Icons.chat, color: Color(0xFFFFD401)),
            label: const Text(
              'JOIN',
              style: TextStyle(
                color: Color(0xFFFFD401),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
