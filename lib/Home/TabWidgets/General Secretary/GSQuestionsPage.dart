import 'package:flutter/material.dart';

import '../../../Utils/Constants.dart';
import '../../../Utils/Helper.dart';

class GSQuestionsPage extends StatefulWidget {
  const GSQuestionsPage({super.key});

  @override
  State<GSQuestionsPage> createState() => _GSQuestionsPageState();
}

class _GSQuestionsPageState extends State<GSQuestionsPage> {
  final TextEditingController _questionController = TextEditingController();


  @override
  void initState() {
    super.initState();
    getPeople();
  }


  //post_question.php


  var _loading = false;
  List<dynamic> question_and_answers = [];
  getPeople(){
    requestAPI(getApiURL("retrieve_questions_and_answers.php"), {"":""}, (loading){setState(() {
      _loading = loading;
    });}, (response){
      setState(() {
        question_and_answers = response;

      });
    }, (error){}, method: "GET");
  }


  sendQuestion(){
    if(_questionController.text.trim().isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a question")),
      );
      return;
    }

    requestAPI(getApiURL("post_question.php"), {"question":_questionController.text.trim()}, (loading){setState(() {
      _loading = loading;
    });}, (response){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Question submitted successfully")),
      );
      _questionController.clear();
      getPeople();
    }, (error){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $error")),
      );
    }, method: "POST");
  }

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
                    sendQuestion();
                    //_questionController.clear();
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

            if (_loading)
              const Center(
                child: CircularProgressIndicator(),
              ),

            // Q&A List
            Expanded(
              child: ListView.builder(
                itemCount: question_and_answers.length,
                itemBuilder: (context, index) {
                  final qa = question_and_answers[index];
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
