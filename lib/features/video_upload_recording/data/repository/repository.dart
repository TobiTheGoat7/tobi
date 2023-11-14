import 'package:fpdart/fpdart.dart';
import 'package:outt/core/failures/failure.dart';

abstract class VideoUploadRepository {
  /// Takes a video url
  /// and returns the of the compressed version.
  Future<void> compressVideo(String videoUrl);

  // Selects and returns a videoo File
  Future<Either<Failure, void>> selectVideo();

  // Save the video file so you don't compress again
  Future<Either<Failure, void>> saveCompressedVideo();

  // upload the video File and return it's url;
  Future<void> uploadVideo();

  // get video from camera ;
  Future<void> recordVideo();
}

class VideoUploadRepositoryI implements VideoUploadRepository {
  @override
  Future<void> compressVideo(String videoUrl) {
    // TODO: implement compressVideo
    throw UnimplementedError();
  }

  @override
  Future<void> recordVideo() {
    // TODO: implement recordVideo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> saveCompressedVideo() {
    // TODO: implement saveCompressedVideo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> selectVideo() {
    // TODO: implement selectVideo
    throw UnimplementedError();
  }

  @override
  Future<void> uploadVideo() {
    // TODO: implement uploadVideo
    throw UnimplementedError();
  }
}
