import 'dart:io';

// import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class CachedVideoWidget extends StatefulWidget {
  final String? videoUrl;
  const CachedVideoWidget({
    super.key,
    required this.videoUrl,
  });

  @override
  State<CachedVideoWidget> createState() => _CachedVideoWidgetState();
}

class _CachedVideoWidgetState extends State<CachedVideoWidget> {
  // late CachedVideoPlayerController controller;
  File? thumbnail;

  @override
  void initState() {
    super.initState();

    // controller = CachedVideoPlayerController.network(widget.videoUrl ?? '');
    // controller.initialize().then((value) {
    //   controller.seekTo(const Duration(seconds: 10));
    //   controller.setVolume(0);
    //   setState(() {});
    // });
  }

  Future<void> generateThumbnail() async {
    final fileName = await VideoThumbnail.thumbnailFile(
      video: widget.videoUrl ?? '',
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.WEBP,
      maxHeight:
          200, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 90,
      timeMs: 20,
    );
    if (fileName != null) {
      thumbnail = File(fileName);
      setState(() {});
    }
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (controller.value.isInitialized && widget.videoUrl != null) {
    //   return Center(
    //     child: FittedBox(
    //       fit: BoxFit.fill,
    //       child: SizedBox(
    //         height: controller.value.size.height,
    //         width: controller.value.size.width,
    //         child: CachedVideoPlayer(controller),
    //       ),
    //     ),
    //   );
    // } else if (controller.value.hasError) {
    //   return const Icon(Icons.error_outline);
    // } else {
    return const Center(
      child: CircularProgressIndicator(),
    );
    // }
  }
}
