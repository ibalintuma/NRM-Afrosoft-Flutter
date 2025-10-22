import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:nrm_afrosoft_flutter/Utils/Helper.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class AIChatPage extends StatefulWidget {
  const AIChatPage({super.key});

  @override
  State<AIChatPage> createState() => _AIChatPageState();
}

class _AIChatPageState extends State<AIChatPage> with SingleTickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isLoading = false;

  // Speech to text
  late stt.SpeechToText _speech;
  bool _isListening = false;
  bool _speechAvailable = false;
  String _lastWords = '';

  // Animation for mic button
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initSpeech();

    // Initialize animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  void _initSpeech() async {
    _speech = stt.SpeechToText();
    _speechAvailable = await _speech.initialize(
      onStatus: (status) {
        print("OSCA");
        customLog('Speech recognition status: $status');
        if (status == 'done' || status == 'notListening') {
          setState(() {
            _isListening = false;
          });
        }
      },
      onError: (error) {
        print("ERROR");
        customLog('Speech recognition error: $error');
        setState(() {
          _isListening = false;
        });
        _showSnackBar('Error: ${error.errorMsg}');
      },
    );

    if (!_speechAvailable) {
      customLog('Speech recognition not available');
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _speech.stop();
    _animationController.dispose();
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

  Future<void> _startListening() async {
    if (!_speechAvailable) {
      _showSnackBar('Speech recognition not available');
      return;
    }

    // Check microphone permission
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      _showSnackBar('Microphone permission denied');
      return;
    }

    if (!_isListening) {
      setState(() {
        _isListening = true;
        _lastWords = '';
      });

      await _speech.listen(
        onResult: (result) {
          setState(() {
            _lastWords = result.recognizedWords;
            _messageController.text = _lastWords;
          });
        },
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 3),
        partialResults: true,
        cancelOnError: true,
        listenMode: stt.ListenMode.confirmation,
      );
    }
  }

  Future<void> _stopListening({bool sendMessage = false}) async {
    if (_isListening) {
      await _speech.stop();
      setState(() {
        _isListening = false;
      });

      if (sendMessage && _lastWords.isNotEmpty) {
        // Small delay to ensure the text is fully captured
        await Future.delayed(const Duration(milliseconds: 300));
        _sendMessage();
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Parse markdown-like text and return TextSpan with proper formatting
  TextSpan _parseMarkdownText(String text, Color textColor) {
    final List<TextSpan> spans = [];
    final regex = RegExp(
        r'\*\*(.*?)\*\*|\*(.*?)\*|`(.*?)`|^###\s(.+)$|^##\s(.+)$|^#\s(.+)$|^\*\s(.+)$|^-\s(.+)$|^\d+\.\s(.+)$',
        multiLine: true);

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
      } else if (match.group(4) != null ||
          match.group(5) != null ||
          match.group(6) != null) {
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
          style: const TextStyle(
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

  Widget _buildMicButton() {
    return GestureDetector(
      onLongPressStart: (_) => _startListening(),
      onLongPressEnd: (_) => _stopListening(sendMessage: true),
      onTap: () {
        if (_isListening) {
          _stopListening(sendMessage: false);
        } else {
          _startListening();
        }
      },
      child: AnimatedBuilder(
        animation: _isListening ? _scaleAnimation : const AlwaysStoppedAnimation(1.0),
        builder: (context, child) {
          return Transform.scale(
            scale: _isListening ? _scaleAnimation.value : 1.0,
            child: Container(
              decoration: BoxDecoration(
                color: _isListening
                    ? Colors.red
                    : const Color(0xFFFFD401),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: (_isListening ? Colors.red : Colors.black)
                        .withOpacity(0.3),
                    blurRadius: _isListening ? 12 : 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(
                  _isListening ? Icons.mic : Icons.mic_none,
                  color: _isListening ? Colors.white : Colors.black,
                ),
                onPressed: null, // Handled by GestureDetector
                tooltip: _isListening
                    ? 'Listening... (tap to stop)'
                    : 'Tap or hold to speak',
              ),
            ),
          );
        },
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
          // Listening indicator
          if (_isListening)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                border: Border(
                  bottom: BorderSide(color: Colors.red.shade200, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.mic, color: Colors.red, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    _lastWords.isEmpty
                        ? 'Listening... Speak now'
                        : 'Listening...',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  ),
                ],
              ),
            ),

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
                  // 🎙️ Mic button with tap and hold
                  _buildMicButton(),
                  const SizedBox(width: 10),

                  // ✍️ Text field
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      enabled: !_isLoading,
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: _isListening
                            ? 'Listening...'
                            : 'Type or speak your question...',
                        hintStyle: TextStyle(
                          color: _isListening
                              ? Colors.red.shade300
                              : Colors.grey.shade500,
                        ),
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
                            color: _isListening
                                ? Colors.red.shade300
                                : Colors.grey.shade300,
                            width: _isListening ? 2 : 1,
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