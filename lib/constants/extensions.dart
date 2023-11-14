import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:outt/core/failures/failure.dart';
import 'package:outt/features/common/app_snackbar.dart';

extension IntegerExtensions on int {
  String toOrdinalText() {
    return this == 0
        ? 'Zeroth'
        : this == 1
            ? 'First'
            : this == 2
                ? 'Second'
                : this == 3
                    ? 'Third'
                    : this == 4
                        ? 'Fourth'
                        : this == 5
                            ? 'Fifth'
                            : 'Unhandled';
  }
}

extension DateTimeExtensions on DateTime {
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}

///this returns the width and height dimensions of a text as a size.
Size measureTextSize(String text, TextStyle style,
    {int maxLines = 1, TextDirection direction = TextDirection.ltr}) {
  final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: direction)
    ..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size;
}

// Size measureImageSize(Widget widget) {
//   final DecorationImagePainter imagePainter = DecorationImagePainter();
//   ..layout
// }

///This attach the appsnackbar to failure objects.
///
extension FailureExtensions on Failure {
  //used to show the appsnackbar alert.
  void showAlert(BuildContext context) {
    AppSnackbar(context, isError: true)
        .showToast(text: message.replaceAll('_', ' '));
  }
}

extension FileExtensions on File {
  Future<String> getFileSize([int decimals = 2]) async {
    var file = File(path);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${((bytes / pow(1024, i)).toStringAsFixed(decimals))} ${suffixes[i]}';
  }
}
