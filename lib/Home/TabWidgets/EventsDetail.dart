import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Utils/Constants.dart';

class EventsDetail extends StatefulWidget{

  final dynamic event;

  const EventsDetail({super.key, required this.event});

  @override
  State<EventsDetail> createState() {
    return _EventsDetail();
  }

}

class _EventsDetail extends State<EventsDetail>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events Detail'),
        backgroundColor: Color(0xFFFFD401),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
              ),
              child: Image.network(
                getImageURL(
                  "EventImages",
                  //"presidential_address.jpg"
                  widget.event["image"],
                ),
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Color(0xFFFFD401),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${widget.event["title"]}".toUpperCase(),style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  Row(
                    children: [
                      Icon(Icons.place,size: 16,),
                      SizedBox(width: 4),
                      Text(widget.event["venue"] ?? "..."),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Event Date"),
                      Row(
                        children: [
                          SizedBox(width: 10,),
                          Text(widget.event["date"] ?? "...",style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Text("Start Time"),
                      Row(
                        children: [
                          Icon(Icons.access_time,size: 17,),
                          SizedBox(width: 5,),
                          Text(widget.event["start_time"] ?? "...",style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Text("End Time"),
                      Row(
                        children: [
                          Icon(Icons.access_time,size: 17,),
                          SizedBox(width: 5,),
                          Text(widget.event["end_time"] ?? "...",style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Card(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text("Event Details"),
                      Text(widget.event["about"] ?? "...",style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}