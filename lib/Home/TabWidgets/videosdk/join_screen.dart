import 'package:flutter/material.dart';
import 'package:nrm_afrosoft_flutter/Utils/Helper.dart';
import 'api_call.dart';
import 'meeting_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final _meetingIdController = TextEditingController();
  final _reasonController = TextEditingController();
  bool _isLoading = false;
  bool _showJoin = false; // Toggle for join section

  @override
  void dispose() {
    _meetingIdController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> onCreateButtonPressed() async {
    setState(() => _isLoading = true);
    try {
      final meetingId = await createMeeting();
      if (!mounted) return;

      final reason = _reasonController.text.isNotEmpty
          ? _reasonController.text
          : "No reason provided";

      final url = Uri.parse("https://agent.afrosoftug.com/api/calls");
      final body = {'session_id': meetingId, 'reason': reason, 'person_id': "0"};
      final headers = {'Content-Type': 'application/json'};


      final response = await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MeetingScreen(
              meetingId: meetingId,
              token: token,
            ),
          ),
        );

        print(">>>>>>>>>>>>>>.......... 3");
      } else {

        print(">>>>>>>>>>>>>>.......... 4");
        customLog(response.statusCode);
        customLog(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to create session. Try again.")),
        );
      }
    } catch (e) {

      print(">>>>>>>>>>>>>>.......... 5");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void onJoinButtonPressed() {
    final meetingId = _meetingIdController.text;
    final re = RegExp("\\w{4}\\-\\w{4}\\-\\w{4}");

    if (meetingId.isNotEmpty && re.hasMatch(meetingId)) {
      _meetingIdController.clear();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MeetingScreen(
            meetingId: meetingId,
            token: token,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid meeting id")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Call to Call Center'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.video_call, size: 60, color: Theme.of(context).primaryColor),
              const SizedBox(height: 24),
              TextField(
                controller: _reasonController,
                decoration: InputDecoration(
                  labelText: "Reason for call",
                  prefixIcon: const Icon(Icons.message_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : onCreateButtonPressed,
                  icon: _isLoading
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.phone),
                  label: Text(_isLoading ? "Dialing..." : 'Dial to Call Center'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if(false)
              Divider(),
              if(false)
              TextButton.icon(
                icon: Icon(_showJoin ? Icons.expand_less : Icons.expand_more),
                label: Text(_showJoin ? "Hide Join Meeting" : "Show Join Meeting"),
                onPressed: () => setState(() => _showJoin = !_showJoin),
              ),
              if(false)
              if (_showJoin) ...[
                const SizedBox(height: 12),
                TextField(
                  controller: _meetingIdController,
                  decoration: const InputDecoration(
                    labelText: 'Meeting Id (xxxx-xxxx-xxxx)',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onJoinButtonPressed,
                    child: const Text('Join Meeting'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}