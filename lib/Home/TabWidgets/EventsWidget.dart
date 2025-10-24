import 'package:flutter/material.dart';

class EventsWidget extends StatefulWidget {
  const EventsWidget({super.key});

  @override
  State<EventsWidget> createState() => _EventsWidgetState();
}

class _EventsWidgetState extends State<EventsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.event_busy_rounded, color: Colors.grey[500], size: 80),
            const SizedBox(height: 12),
            Text(
              "No events available",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Please check back later",
              style: TextStyle(color: Colors.grey[500], fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
