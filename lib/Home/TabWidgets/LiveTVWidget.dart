import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';

import '../../Utils/Constants.dart';
import '../../Utils/Helper.dart';

class LiveTVWidget extends StatefulWidget {
  const LiveTVWidget({super.key});

  @override
  State<LiveTVWidget> createState() => _LiveTVWidgetState();
}

class _LiveTVWidgetState extends State<LiveTVWidget> {
  YoutubePlayerController? _youtubeController;
  VideoPlayerController? _videoController;

  var _loading = false;
  var streaming_data;
  bool _isDisposed = false;

  retrieveData() {
    requestAPI(getApiURL("get_streaming_data.php"), {"":""}, (loading) {
      if (!_isDisposed && mounted) {
        setState(() {
          _loading = loading;
        });
      }
    }, (response) {
      streaming_data = response;
      // {id: 15, category_id: 1, streaming_link: hwW8PQlVrMk, secure_stream: null, status: 1}
      // category_id 1 = youtube = with video id, or full link in streaming_link
      // category_id 2 = video file link
      if (streaming_data['category_id'] == "1") {
        var sl = streaming_data['streaming_link'];
        if (!sl.startsWith("http")) {
          sl = "https://www.youtube.com/watch?v=${streaming_data['streaming_link']}";
        }
        final videoId = YoutubePlayer.convertUrlToId(sl)!;
        _youtubeController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
            enableCaption: true,
            controlsVisibleAtStart: true,
            forceHD: true,
          ),
        );
      } else {
        // Handle direct video link
        _videoController = VideoPlayerController.networkUrl(
          Uri.parse(streaming_data['streaming_link']),
        )
          ..initialize().then((_) {
            if (!_isDisposed && mounted) {
              setState(() {
                _videoController?.play();
              });
            }
          }).catchError((error) {
            if (!_isDisposed && mounted) {
              customLog('Error initializing video: $error');
            }
          });
      }
      if (!_isDisposed && mounted) {
        setState(() {});
      }
      customLog(streaming_data);
    }, (error) {}, method: "GET");
  }

  @override
  void initState() {
    super.initState();
    retrieveData();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _youtubeController?.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  Widget _buildYouTubePlayer() {
    if (_youtubeController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _youtubeController!,
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
        return Column(
          children: [
            player,
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Widget _buildDirectVideoPlayer() {
    if (_videoController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!_videoController!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        AspectRatio(
          aspectRatio: _videoController!.value.aspectRatio,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              VideoPlayer(_videoController!),
              _buildVideoControls(),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildVideoControls() {
    return Container(
      color: Colors.black26,
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              _videoController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
            onPressed: () {
              if (!_isDisposed && mounted) {
                setState(() {
                  _videoController!.value.isPlaying
                      ? _videoController!.pause()
                      : _videoController!.play();
                });
              }
            },
          ),
          Expanded(
            child: VideoProgressIndicator(
              _videoController!,
              allowScrubbing: true,
              colors: const VideoProgressColors(
                playedColor: Color(0xFFFFD401),
                bufferedColor: Colors.grey,
                backgroundColor: Colors.white24,
              ),
            ),
          ),
          Text(
            _formatDuration(_videoController!.value.position),
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          const Text(
            ' / ',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          Text(
            _formatDuration(_videoController!.value.duration),
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    if (duration.inHours > 0) {
      return '$hours:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Center(child: bossBaseLoader());
    }

    if (streaming_data == null) {
      return const Center(child: Text('No streaming data available'));
    }

    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(0),
      child: (streaming_data == null)
          ? Container()
          : (streaming_data['category_id'] == "1"
          ? _buildYouTubePlayer()
          : _buildDirectVideoPlayer()),
    );
  }
}