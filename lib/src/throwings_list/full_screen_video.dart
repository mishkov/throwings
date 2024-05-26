import 'package:flutter/material.dart';
import 'package:throwings/src/throwings_list/toggle_play_button.dart';
import 'package:throwings/src/throwings_list/video_time_line.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideo extends StatelessWidget {
  const FullScreenVideo({
    super.key,
    required VideoPlayerController? controller,
  }) : _controller = controller;

  final VideoPlayerController? _controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Stack(
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(
                  _controller,
                ),
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
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.fullscreen_exit_rounded,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
