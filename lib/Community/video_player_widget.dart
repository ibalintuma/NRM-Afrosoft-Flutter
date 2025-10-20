import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({required this.videoUrl});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? _controller;
  bool _isPlaying = false;
  String? _thumbnailPath;
  bool _isThumbnailLoading = true;

  @override
  void initState() {
    super.initState();
    _generateThumbnail();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _generateThumbnail() async {
    try {
      final thumbnail = await VideoThumbnail.thumbnailFile(
        video: widget.videoUrl,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.PNG,
        maxHeight: 200,
        quality: 75,
      );
      
      if (mounted) {
        setState(() {
          _thumbnailPath = thumbnail;
          _isThumbnailLoading = false;
        });
      }
    } catch (e) {
      print('Error generating thumbnail: $e');
      if (mounted) {
        setState(() {
          _isThumbnailLoading = false;
        });
      }
    }
  }

  void _initializeAndPlay() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          _isPlaying = true;
        });
        _controller!.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isPlaying) {
      return GestureDetector(
        onTap: _initializeAndPlay,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 200,
                color: Colors.black12,
                child: _isThumbnailLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : _thumbnailPath != null
                        ? Image.file(
                            File(_thumbnailPath!),
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                        : const Center(
                            child: Icon(Icons.videocam, size: 50, color: Colors.grey),
                          ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(12),
                child: const Icon(
                  Icons.play_arrow,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return _controller!.value.isInitialized
        ? ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  VideoPlayer(_controller!),
                  VideoProgressIndicator(_controller!, allowScrubbing: true),
                ],
              ),
            ),
          )
        : const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
  }
}