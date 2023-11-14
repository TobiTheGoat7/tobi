import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppAssetImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  const AppAssetImage({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.none,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (getImageType(url) == ImageType.svg) {
      return SvgPicture.asset(
        url,
        height: height,
        width: width,
        fit: fit,
      );
    } else {
      return Image.asset(
        url,
        height: height,
        width: width,
        fit: fit,
        color: color,
      );
    }
  }

  ImageType getImageType(String url) {
    var path = url.split(".");
    String ext = path[path.length - 1];
    if (ext == "svg") return ImageType.svg;
    return ImageType.png;
  }
}

enum ImageType { svg, png }
