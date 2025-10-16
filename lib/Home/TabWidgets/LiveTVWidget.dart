import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LiveTVWidget extends StatefulWidget {
  const LiveTVWidget({super.key});

  @override
  State<LiveTVWidget> createState() => _LiveTVWidgetState();
}

class _LiveTVWidgetState extends State<LiveTVWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    const videoUrl =
        "https://www.youtube.com/watch?v=ysz5S6PUM-U"; // Replace with your video
    final videoId = YoutubePlayer.convertUrlToId(videoUrl)!;

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        enableCaption: true,
        controlsVisibleAtStart: true,
        forceHD: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: const Color(0xFFFFD401),
        progressColors: const ProgressBarColors(
          playedColor: Color(0xFFFFD401),
          handleColor: Colors.yellow,
        ),
        bottomActions: [
          const SizedBox(width: 8),
          CurrentPosition(),
          const SizedBox(width: 8),
          ProgressBar(isExpanded: true),
          const SizedBox(width: 8),
          RemainingDuration(),
          FullScreenButton(),
        ],
      ),
      builder: (context, player) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              player,
              const SizedBox(height: 20),
              // const Text(
              //   "NRM Live TV",
              //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              // ),
            ],
          ),
        );
      },
    );
  }
}
