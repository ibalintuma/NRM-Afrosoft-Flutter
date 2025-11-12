import 'package:flutter/material.dart';

import '../../Utils/Constants.dart';
import '../../Utils/Helper.dart';

class AskPage extends StatefulWidget {
  const AskPage({super.key});

  @override
  State<AskPage> createState() => _AskPageState();
}

class _AskPageState extends State<AskPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }


  var _loadingData = false;
  void submitData() {

    //name,email,subject,message
    requestAPI(getApiURL("api/ask_the_presidents"), {
      "name": _nameController.text,
      "email": _emailController.text,
      "subject": _subjectController.text,
      "message": _messageController.text,
    }, (loading){
      setState(() {
        _loadingData = loading;
      });
    }, (response){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Message sent successfully!")),
      );
      Navigator.pop(context);

    }, (error){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Caution; failed to submit')),
      );
    }, method: "POST");

  }

  void _sendMessage() {
    if (_formKey.currentState!.validate()) {
      // Handle sending message

      submitData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Ask the President',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: const Color(0xFFFFD401),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please use the form below to send your question or message to the President',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 94, 128, 186),
                ),
              ),
              const SizedBox(height: 24),

              // Name field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Enter your name'
                            : null,
              ),
              const SizedBox(height: 16),

              // Email field
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Enter your email'
                            : null,
              ),
              const SizedBox(height: 16),

              // Subject field
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty ? 'Enter subject' : null,
              ),
              const SizedBox(height: 16),

              // Message field
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(
                  labelText: 'Your Message',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Enter your message'
                            : null,
              ),
              const SizedBox(height: 24),

              if (_loadingData)
                Center(child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: bossBaseLoader(),
                )),

              // Send Message button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _sendMessage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD401),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'SEND MESSAGE',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
