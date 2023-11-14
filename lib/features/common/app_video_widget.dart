import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AppVideoWidget extends StatefulWidget {
  final File file;
  final double? aspectRatio;
  const AppVideoWidget({
    super.key,
    this.aspectRatio,
    required this.file,
  });

  @override
  State<AppVideoWidget> createState() => _AppVideoWidgetState();
}

class _AppVideoWidgetState extends State<AppVideoWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.file(
      widget.file,
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        _controller.setVolume(0);

        _controller.play();

        _controller.setLooping(true);
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Center(
            child: AspectRatio(
              aspectRatio: widget.aspectRatio ?? _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          )
        : Container();
  }
}
