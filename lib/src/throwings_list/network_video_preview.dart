import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:throwings/src/throwings_list/full_screen_video.dart';
import 'package:throwings/src/throwings_list/toggle_play_button.dart';
import 'package:throwings/src/throwings_list/video_time_line.dart';
import 'package:video_player/video_player.dart';

class NetworkVideoPreview extends StatefulWidget {
  const NetworkVideoPreview({
    super.key,
    required this.url,
  });

  final String url;

  @override
  State<NetworkVideoPreview> createState() => _NetworkVideoPreviewState();
}

class _NetworkVideoPreviewState extends State<NetworkVideoPreview> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even
        // before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isInitialized = _controller?.value.isInitialized ?? false;
    if (_controller == null || !isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Skeletonizer(
          child: Bone(
            height: double.infinity,
            width: double.infinity,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    }

    return Stack(
      children: [
        Container(
          constraints: const BoxConstraints(maxHeight: 300),
          alignment: Alignment.center,
          child: AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: VideoPlayer(_controller!),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: <Color>[
                  Colors.black87,
                  Colors.transparent,
                ],
              ),
            ),
            child: Row(
              children: [
                TogglePlayButton(controller: _controller),
                Expanded(
                  child: VideoTimeLine(controller: _controller),
                ),
                IconButton(
                  onPressed: () => unawaited(_showFullScreen()),
                  icon: const Icon(
                    Icons.fullscreen_rounded,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showFullScreen() async {
    await showDialog(
      context: context,
      builder: (context) {
        return FullScreenVideo(controller: _controller);
      },
    );
    setState(() {});
  }
}
