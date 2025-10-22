import 'package:flutter/material.dart';

class GSQuestionsPage extends StatefulWidget {
  const GSQuestionsPage({super.key});

  @override
  State<GSQuestionsPage> createState() => _GSQuestionsPageState();
}

class _GSQuestionsPageState extends State<GSQuestionsPage> {
  final TextEditingController _questionController = TextEditingController();

  // Demo data
  final List<Map<String, String>> demoQA = [
    {
      "question": "What is the main objective of the NRM government?",
      "answer":
          "The main objective is to ensure socio-economic transformation and inclusive development for all Ugandans.",
    },
    {
      "question": "How can citizens participate in NRM programs?",
      "answer":
          "Citizens can participate by joining local committees, attending community meetings, and engaging in national dialogues.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ask The General Secretary"),
        backgroundColor: Color(0xFFFFD401),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input Field Row
            Row(
              children: [
                // Leading avatar
                const CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 8),

                // Text Field
                Expanded(
                  child: TextField(
                    controller: _questionController,
                    decoration: const InputDecoration(
                      hintText: "Type your question here...",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Send button
                GestureDetector(
                  onTap: () {
                    // Later handle sending to API
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Question sent!")),
                    );
                    _questionController.clear();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFD401),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send,
                      color: Colors.black,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            const Divider(thickness: 1.2),

            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Questions and Answers",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 8),

            // Q&A List
            Expanded(
              child: ListView.builder(
                itemCount: demoQA.length,
                itemBuilder: (context, index) {
                  final qa = demoQA[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    elevation: 2,
                    child: ExpansionTile(
                      title: Text(
                        "Qn. ${qa['question']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text(
                            "Ans. ${qa['answer']}",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
