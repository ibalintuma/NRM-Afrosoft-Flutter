import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:videosdk/videosdk.dart';
import './participant_tile.dart';
import 'join_screen.dart';
import 'meeting_controls.dart';

class MeetingScreen extends StatefulWidget {
  final String meetingId;
  final String token;

  const MeetingScreen(
      {super.key, required this.meetingId, required this.token});

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  late Room _room;
  var micEnabled = true;
  var camEnabled = true;

  Map<String, Participant> participants = {};

  @override
  void initState() {
    // create room
    _room = VideoSDK.createRoom(
        roomId: widget.meetingId,
        token: widget.token,
        displayName: "John Doe",
        micEnabled: micEnabled,
        camEnabled: camEnabled,
        defaultCameraIndex: kIsWeb
            ? 0
            : 1  // Index of MediaDevices will be used to set default camera
    );

    setMeetingEventListener();

    // Join room
    _room.join();

    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  // listening to meeting events
  void setMeetingEventListener() {
    _room.on(Events.roomJoined, () {
      setState(() {
        participants.putIfAbsent(
            _room.localParticipant.id, () => _room.localParticipant);
      });
    });

    _room.on(
      Events.participantJoined,
          (Participant participant) {
        setState(
              () => participants.putIfAbsent(participant.id, () => participant),
        );
      },
    );

    _room.on(Events.participantLeft, (String participantId) {
      if (participants.containsKey(participantId)) {
        setState(
              () => participants.remove(participantId),
        );
      }
    });

    _room.on(Events.roomLeft, () {
      participants.clear();
      //Navigator.popUntil(context, ModalRoute.withName('/'));
      Navigator.pop(context);
    });
  }

  // onbackButton pressed leave the room
  Future<bool> _onWillPop() async {
    _room.leave();
    return true;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: ( bool didPop, result) async {
        _room.leave();


        if(didPop){
          return;
        }

        final bool shouldPop = await _showBackDialog() ?? false;
        if( context.mounted && shouldPop){
          Navigator.pop(context);
        }
        //Navigator.pop(context);
      },
      //onWillPop: () => _onWillPop(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Call Session'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(widget.meetingId),
              //render all participant
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 300,
                    ),
                    itemBuilder: (context, index) {
                      return ParticipantTile(
                          key: Key(participants.values.elementAt(index).id),
                          participant: participants.values.elementAt(index));
                    },
                    itemCount: participants.length,
                  ),
                ),
              ),





              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        _room.leave();
                      },
                      child: Container(
                          margin: EdgeInsets.all(4),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.exit_to_app, color: Colors.white,),
                              SizedBox(width: 5,),
                              Text("Leave", style: TextStyle(color: Colors.white, fontSize: 12),)
                            ],
                          )),
                    ),
                    GestureDetector(
                      onTap: (){
                        micEnabled ? _room.muteMic() : _room.unmuteMic();
                        micEnabled = !micEnabled;
                        setState(() {});
                      },
                      child: Container(
                          margin: EdgeInsets.all(4),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            children: [
                              Icon(micEnabled ? Icons.mic : Icons.code_off, color: Colors.white,),
                              SizedBox(width: 5,),
                              Text("Voice", style: TextStyle(color: Colors.white, fontSize: 12),)
                            ],
                          )),
                    ),
                    GestureDetector(
                      onTap: (){
                        camEnabled ? _room.disableCam() : _room.enableCam();
                        camEnabled = !camEnabled;
                        setState(() {});
                      },
                      child: Container(
                          margin: EdgeInsets.all(4),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            children: [
                              Icon(camEnabled ? Icons.camera_alt_outlined : Icons.code_off, color: Colors.white,),
                              SizedBox(width: 5,),
                              Text("Camera", style: TextStyle(color: Colors.white, fontSize: 12),)
                            ],
                          )),
                    ),
                  ],
                ),
              ),



            ],
          ),
        ),
      ),
      //home: JoinScreen(),
    );
  }

  Future<bool?> _showBackDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to leave the meeting?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Never Mind'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}