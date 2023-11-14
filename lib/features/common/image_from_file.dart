import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageFromFile extends StatelessWidget {
  final File? file;
  final BoxFit? fit;
  const ImageFromFile({
    super.key,
    required this.file,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return file == null
        ? const SizedBox.shrink()
        : Image.file(
            file!,
            fit: fit ?? BoxFit.fitWidth,
          );
  }
}

class AppCachedImageWidget extends StatelessWidget {
  final String? imageUrl;

  const AppCachedImageWidget({super.key, required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return imageUrl == null
        ? const SizedBox.shrink()
        : CachedNetworkImage(
            imageUrl: imageUrl!,
            errorWidget: (context, url, error) => const Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 15,
            ),
          );
  }
}
