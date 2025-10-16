import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFD401),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD401),
        foregroundColor: Colors.black,
        title: Text(
          'Our History',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ), // empty title
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top image card

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
                        SizedBox(height: 8),
                        Text('''
The precursors (entobo, entango, entandikairra, tere – Luo, alibuneta - Ateso) of the National resistance Movement (NRM) started in the student movement of the 1960’s and in the old parties (Uganda People’s Congress – UPC, Democratic Party – DP and Kabaka Yekka - KY), it was at a time when our country was facing disaster on account of the “false start” it was made because of the pseudo-ideology of sectarianism of religion and tribe, gender chauvinism (suppressing the women) and marginalizing the youth and the disabled. Those were the three words: sectarianism, suppression and marginalization.

The National Resistance Movement is a social-democratic liberation movement, it is a product of the protracted struggles of the people of Uganda stretching from the days of Uganda’s anti-colonial struggles and other subsequent activities of freedom fighters, which always aimed at fighting injustice and exploitation.

The ideology of a liberation struggle is always an imperative for its success at any given point in history. In Uganda, some liberation Organisations did not register enduring victory largely because of their ideological disposition.

The National Resistance Movement waged and won a protracted people’s war in a record time of five years. The NRM has since 1986 consolidated the people’s victory and used it to embark on massive recovery and transformation of Uganda’s socio-economic landscape.

The big question is why has the NRM been able to achieve all this? The answer largely lies in the aspects of following:-

   a)      A correct line in politics (Democracy and good governance, Nationalism, Patriotism and Pan Africanism)

   b)      A correct military line, (Pro people army; protecting the people and their properties)

   c)       A correct organizational line, (a clear program of action in politics, social sector, and a mixed private sector led self-sustaining, independent, integrated national economy.)

Any institution derives its strength or weakness from the character and capacity of its founding leader. Bad leaders create bad systems (just like Hitler did) while good leaders create good systems and strong institutions that live and stand the test of time.

Therefore, the successive victories that NRM has registered as well as the confidence it has won from the citizenry over the years is largely a manifestation of its good foundational tenets well thought out and pursued by its leaders.
''', style: TextStyle(color: Colors.black, fontSize: 14)),
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
          ],
        ),
      ),
    );
  }
}
