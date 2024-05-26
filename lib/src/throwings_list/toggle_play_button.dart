import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TogglePlayButton extends StatefulWidget {
  const TogglePlayButton({
    super.key,
    this.controller,
  });

  final VideoPlayerController? controller;

  @override
  State<TogglePlayButton> createState() => _TogglePlayButtonState();
}

class _TogglePlayButtonState extends State<TogglePlayButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.controller?.value.isPlaying ?? false) {
      return IconButton(
        onPressed: () {
          setState(() {
            widget.controller?.pause();
          });
        },
        icon: const Icon(
          Icons.pause_rounded,
        ),
      );
    } else {
      return IconButton(
        onPressed: () {
          setState(() {
            widget.controller?.play();
          });
        },
        icon: const Icon(
          Icons.play_arrow_rounded,
        ),
      );
    }
  }
}
