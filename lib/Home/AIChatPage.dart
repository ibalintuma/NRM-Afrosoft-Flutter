import 'package:flutter/material.dart';

class AIChatPage extends StatefulWidget {
  const AIChatPage({super.key});

  @override
  State<AIChatPage> createState() => _AIChatPageState();
}

class _AIChatPageState extends State<AIChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages =
      []; // each message = {'text': '', 'isUser': true}

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'text': text, 'isUser': true});
      _messageController.clear();
    });

    // TODO: later integrate AI reply here
  }

  void _clearChat() {
    setState(() => _messages.clear());
  }

  void _recordAudio() {
    // TODO: integrate voice recording or speech-to-text later
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Voice input coming soon...")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFD401),
        title: const Text(
          'ASK NRM',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: _clearChat,
            child: const Text(
              'Clear Chat',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat area
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['isUser'] as bool;

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.green[600] : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message['text'],
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Input area
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            color: Colors.grey.shade200,
            child: Row(
              children: [
                // 🎙️ Mic button
                CircleAvatar(
                  backgroundColor: const Color(0xFFFFD401),
                  child: IconButton(
                    icon: const Icon(Icons.mic, color: Colors.black),
                    onPressed: _recordAudio,
                  ),
                ),
                const SizedBox(width: 8),

                // ✍️ Text field
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your question...',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // 📤 Send button
                CircleAvatar(
                  backgroundColor: Colors.black,
                  child: IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: const Color(0xFFFFD401),
                    ),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
