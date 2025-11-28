import 'package:flutter/material.dart';

import '../../Utils/Constants.dart';
import '../../Utils/Helper.dart';
import 'EventsDetail.dart';

class EventsWidget extends StatefulWidget {
  const EventsWidget({super.key});

  @override
  State<EventsWidget> createState() => _EventsWidgetState();
}

class _EventsWidgetState extends State<EventsWidget> {
  var _loading_events = false;
  var _events = [];
  void get_achievements() {
    requestAPI(
      getApiURL("retrieve_all_events.php"),
      {"": ""},
          (loading) {
        setState(() {
          _loading_events = loading;
        });
      },
          (response) {
        print("_events");
        setState(() {
          _events = response;
        });
        print(_events);
      },
          (error) {},
      method: "GET",
    );
  }

  @override
  void initState() {
    super.initState();
    get_achievements();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading_events) {
      return Center(child: bossBaseLoader());
    }

    if (_events.isEmpty) {
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

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      itemCount: _events.length,
      itemBuilder: (context, index) {
        var event = _events[index];
        //{"id":"14","title":"presidential Campaign Programme","venue":"Buyende & Kaliro","image":"event_1763373038.jpg","date":"2025-11-18","start_time":null,"end_time":null,"about":null,"lat":"60","lng":"60"}

        //date month is Oct
        var eventDate = DateTime.parse(event["date"]);
        String month = getMonthName(eventDate.month);
        String day = eventDate.day.toString();

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventsDetail(event: event),
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                  child: Image.network(
                    getImageURL(
                      "EventImages",
                      event["image"],
                    ),
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "$month",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text("$day"),
                        ],
                      ),
                      Container(
                        width: 1,
                        color: Colors.black,
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event["title"],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.place,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(event["venue"]),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String getMonthName(int month) {
    const monthNames = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sept",
      "Oct",
      "Nov",
      "Dec"
    ];
    return monthNames[month - 1];
  }
}