import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoTimeLine extends StatefulWidget {
  const VideoTimeLine({
    super.key,
    this.controller,
  });

  final VideoPlayerController? controller;

  @override
  State<VideoTimeLine> createState() => _VideoTimeLineState();
}

class _VideoTimeLineState extends State<VideoTimeLine> {
  double? _pendingPosition;

  @override
  void initState() {
    super.initState();

    widget.controller?.addListener(_updateVideoControlButtons);
  }

  void _updateVideoControlButtons() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_updateVideoControlButtons);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final end = widget.controller?.value.duration.inSeconds.toDouble();
    final current = widget.controller?.value.position.inSeconds.toDouble();
    return Slider(
      max: end ?? 0.0,
      value: _pendingPosition ?? current ?? 0.0,
      onChanged: (value) {
        setState(() {
          _pendingPosition = value;
        });
      },
      onChangeEnd: (value) {
        widget.controller?.seekTo(Duration(seconds: value.toInt()));

        _pendingPosition = null;
      },
    );
  }
}
