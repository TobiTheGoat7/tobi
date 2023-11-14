import 'package:outt/core/failures/failure.dart';

class UploadState {}

class InitialUploadState extends UploadState {}

class UploadFileSuccess extends UploadState {
  final String url;

  UploadFileSuccess(this.url);
}

class UploadImagesSuccess extends UploadState {
  final List<String> urls;

  UploadImagesSuccess(this.urls);
}

class UploadStateFailure extends UploadState {
  final Failure failure;

  UploadStateFailure(this.failure);
}

class UploadingFileState extends UploadState {
  final double progress;

  UploadingFileState(this.progress);
}
