import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:nrm_afrosoft_flutter/Utils/Helper.dart';

class AIChatPage extends StatefulWidget {
  const AIChatPage({super.key});

  @override
  State<AIChatPage> createState() => _AIChatPageState();
}

class _AIChatPageState extends State<AIChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _isLoading) return;

    // Add user message
    setState(() {
      _messages.add({'text': text, 'isUser': true});
      _messageController.clear();
      _isLoading = true;
    });

    _scrollToBottom();

    try {
      final gemini = Gemini.instance;
      String aiResponse = '';

      // Add placeholder for AI response
      setState(() {
        _messages.add({'text': '', 'isUser': false});
      });

      // Stream AI response
      await for (var value in gemini.streamGenerateContent(text)) {
        if (value.output != null) {
          aiResponse += value.output!;
          setState(() {
            _messages[_messages.length - 1]['text'] = aiResponse;
          });
          _scrollToBottom();
        }
      }

      // If no response received, show error
      if (aiResponse.isEmpty) {
        setState(() {
          _messages[_messages.length - 1]['text'] =
          'Sorry, I couldn\'t generate a response. Please try again.';
        });
      }
    } catch (e) {
      customLog('Error: $e');
      setState(() {
        if (_messages.isNotEmpty && !_messages.last['isUser']) {
          _messages[_messages.length - 1]['text'] =
          'Error: Unable to get response. Please check your connection and try again.';
        }
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _clearChat() {
    if (_messages.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Chat'),
        content: const Text('Are you sure you want to clear all messages?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() => _messages.clear());
              Navigator.pop(context);
            },
            child: const Text(
              'Clear',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _recordAudio() {
    // TODO: integrate voice recording or speech-to-text later
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Voice input coming soon..."),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Parse markdown-like text and return TextSpan with proper formatting
  TextSpan _parseMarkdownText(String text, Color textColor) {
    final List<TextSpan> spans = [];
    final regex = RegExp(r'\*\*(.*?)\*\*|\*(.*?)\*|`(.*?)`|^###\s(.+)$|^##\s(.+)$|^#\s(.+)$|^\*\s(.+)$|^-\s(.+)$|^\d+\.\s(.+)$', multiLine: true);

    int currentIndex = 0;

    for (final match in regex.allMatches(text)) {
      // Add normal text before the match
      if (match.start > currentIndex) {
        spans.add(TextSpan(
          text: text.substring(currentIndex, match.start),
          style: TextStyle(color: textColor),
        ));
      }

      // Handle different markdown patterns
      if (match.group(1) != null) {
        // **bold**
        spans.add(TextSpan(
          text: match.group(1),
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ));
      } else if (match.group(2) != null) {
        // *italic*
        spans.add(TextSpan(
          text: match.group(2),
          style: TextStyle(
            color: textColor,
            fontStyle: FontStyle.italic,
          ),
        ));
      } else if (match.group(3) != null) {
        // `code`
        spans.add(TextSpan(
          text: match.group(3),
          style: TextStyle(
            color: textColor,
            fontFamily: 'monospace',
            backgroundColor: Colors.grey.withOpacity(0.2),
          ),
        ));
      } else if (match.group(4) != null || match.group(5) != null || match.group(6) != null) {
        // Headers (###, ##, #)
        final headerText = match.group(4) ?? match.group(5) ?? match.group(6);
        spans.add(TextSpan(
          text: '\n$headerText\n',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ));
      } else if (match.group(7) != null || match.group(8) != null) {
        // Bullet points (*, -)
        final bulletText = match.group(7) ?? match.group(8);
        spans.add(TextSpan(
          text: '\n  • $bulletText',
          style: TextStyle(color: textColor),
        ));
      } else if (match.group(9) != null) {
        // Numbered lists
        spans.add(TextSpan(
          text: '\n  ${match.group(0)}',
          style: TextStyle(color: textColor),
        ));
      }

      currentIndex = match.end;
    }

    // Add remaining text
    if (currentIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(currentIndex),
        style: TextStyle(color: textColor),
      ));
    }

    return TextSpan(children: spans);
  }

  Widget _buildMessage(Map<String, dynamic> message, int index) {
    final isUser = message['isUser'] as bool;
    final text = message['text'] as String;
    final textColor = isUser ? Colors.white : Colors.black87;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        padding: const EdgeInsets.all(14),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUser ? Colors.green[600] : Colors.grey.shade300,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: text.isEmpty && !isUser
            ? Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.grey.shade600,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Thinking...',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        )
            : SelectableText.rich(
          _parseMarkdownText(text, textColor),
          style: TextStyle(
            fontSize: 15,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Start a conversation',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Ask me anything about NRM',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD401),
        elevation: 2,
        title: const Text(
          'ASK NRM',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          if (_messages.isNotEmpty)
            TextButton.icon(
              onPressed: _clearChat,
              icon: const Icon(Icons.delete_outline, color: Colors.black),
              label: const Text(
                'Clear',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // Chat area
          Expanded(
            child: _messages.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 12,
              ),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index], index);
              },
            ),
          ),

          // Loading indicator
          if (_isLoading)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.grey.shade600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'AI is typing...',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

          // Input area
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // 🎙️ Mic button
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD401),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.mic, color: Colors.black),
                      onPressed: _isLoading ? null : _recordAudio,
                      tooltip: 'Voice input',
                    ),
                  ),
                  const SizedBox(width: 10),

                  // ✍️ Text field
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      enabled: !_isLoading,
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: 'Type your question...',
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(
                            color: Color(0xFFFFD401),
                            width: 2,
                          ),
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // 📤 Send button
                  Container(
                    decoration: BoxDecoration(
                      color: _isLoading ? Colors.grey : Colors.black,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        _isLoading ? Icons.stop : Icons.send,
                        color: const Color(0xFFFFD401),
                      ),
                      onPressed: _isLoading ? null : _sendMessage,
                      tooltip: 'Send message',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}