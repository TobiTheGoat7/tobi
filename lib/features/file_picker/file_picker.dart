import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outt/features/common/text_widgets.dart';

Future<File?> pickFile({
  AppFileType appFileType = AppFileType.any,
  bool allowMultiple = false,
  required BuildContext context,
}) async {
  File? file;
  final fileType = convertAppFileType(appFileType);

  List<String> allowedExtensions = ['jpg', 'pdf', 'doc', 'png', 'docx'];

  FilePickerResult? filePickerResult;
  if (Platform.isAndroid) {
    filePickerResult = await FilePicker.platform.pickFiles(
      type: fileType,
      allowMultiple: allowMultiple,
      allowedExtensions: fileType == FileType.custom ? allowedExtensions : null,
    );
  } else {
    //for iOS
    final iosFileSource = await _getFileSourceForIos(context);
    if (iosFileSource == null) {
      return null;
    }

    //Determine if should come from photos or file manager.
    final fileType = convertAppFileType(iosFileSource);

    if (appFileType == AppFileType.video && fileType == FileType.image) {
      file = await getVideoFromCamera(ImageSource.gallery);
    } else {
      filePickerResult = await FilePicker.platform.pickFiles(
          type: fileType,
          allowMultiple: allowMultiple,
          allowedExtensions: getAllowedExtensions(fileType, appFileType));
    }
  }
  if (filePickerResult != null) {
    file = File(filePickerResult.files.single.path!);
  }

  return file;
}

enum AppFileType {
  image,
  document,
  video,
  any,
}

FileType convertAppFileType(AppFileType type) {
  switch (type) {
    case AppFileType.image:
      return FileType.image;
    case AppFileType.video:
      return FileType.video;
    case AppFileType.document:
      return FileType.custom;
    case AppFileType.any:
      return FileType.any;
  }
}

List<String>? getAllowedExtensions(
    FileType fileSource, AppFileType typeRequested) {
  if (typeRequested == AppFileType.image && fileSource == FileType.image) {
    //requesting for image from gallery
    return null;
  } else if (typeRequested == AppFileType.image &&
      fileSource != FileType.image) {
    //requesting for image from files (not gallery).
    return ['png', 'jpg', 'jpeg', 'gif', 'heic'];
  } else if (typeRequested == AppFileType.video &&
      fileSource == FileType.image) {
    //requesting for video from gallery
    ///you can't ask specifically for video files from gallery.
    /// This code has been replaced with functionality from ImagePicker.
    return null; //['mp4', 'mkv', 'webm', 'ts'];
  } else if (typeRequested == AppFileType.video &&
      fileSource != FileType.image) {
    //requesting for video from gallery
    return ['mp4', 'mkv', 'webm', 'ts'];
  } else if (typeRequested == AppFileType.document &&
      fileSource != FileType.image) {
    //requesting for file from files
    return ['jpg', 'pdf', 'doc', 'png', 'docx'];
  } else {
    return null;
  }
}

Future<File?> getVideoFromCamera(
    [ImageSource imageSource = ImageSource.camera]) async {
  final ImagePicker picker = ImagePicker();

  final XFile? image = await picker.pickVideo(
    source: imageSource,
    preferredCameraDevice: CameraDevice.front,
  );
  //TODO: this returns a .MOV video file on iOS
  //Consider finding a work around.
  return image != null ? File(image.path) : null;
}

Future<List<File>> getImagesFromDevice() async {
  final ImagePicker picker = ImagePicker();
  List<File> files = [];

  final List<XFile> images = await picker.pickMultiImage();

  for (XFile image in images) {
    files.add(File(image.path));
  }

  return files;
}

Future<AppFileType?> _getFileSourceForIos(BuildContext context) async {
  //It show a bottom sheet which the user can use to choose if to
  //ge the file from photos or file manager on iOS.
  return showModalBottomSheet<AppFileType?>(
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, AppFileType.document);
            },
            child: const NormalText('Files'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, AppFileType.image);
            },
            child: const NormalText('Photos'),
          ),
          const Gap(50.0),
        ],
      );
    },
  );
}
