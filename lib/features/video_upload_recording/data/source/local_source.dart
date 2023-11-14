abstract class VideoUploadLocalSource {
  Future<void> saveCompressedVideoForUpload();
  Future<void> isVideoCompressedBefore(String videoId);
}

class VideoUploadLocalSourceI implements VideoUploadLocalSource {
  @override
  Future<void> isVideoCompressedBefore(String videoId) {
    // TODO: implement isVideoCompressedBefore
    throw UnimplementedError();
  }

  @override
  Future<void> saveCompressedVideoForUpload() {
    // TODO: implement saveCompressedVideoForUpload
    throw UnimplementedError();
  }
}
