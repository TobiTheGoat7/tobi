import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:outt/constants/error_strings.dart';
import 'package:outt/core/failures/failure.dart';
import 'package:outt/core/network_info/network_info.dart';
import 'package:outt/core/runner/service.dart';
import 'package:outt/features/file_upload/data/remote_source.dart';

final uploadFileRepositoryProvider =
    Provider<UploadFileRepository>((ref) => UploadFileRepositoryI(ref));

abstract class UploadFileRepository {
  Future<Either<Failure, String>> uploadEventVideo(
      File video, OnUploadProgressCallback onUploadProgressCallback);
  Future<Either<Failure, List<String>>> uploadImages(
      List<File> images, OnUploadProgressCallback onUploadProgressCallback);
}

class UploadFileRepositoryI implements UploadFileRepository {
  final NetworkInfo _networkInfo;
  final UploadFileRemoteSource _uploadFileRemoteSource;

  UploadFileRepositoryI(Ref ref)
      : _networkInfo = ref.read(networkInfoProvider),
        _uploadFileRemoteSource = ref.read(uploadFileRemoteSourceProvider);

  @override
  Future<Either<Failure, String>> uploadEventVideo(
      File video, OnUploadProgressCallback onUploadProgressCallback) {
    ServiceRunner<Failure, String> sR = ServiceRunner(_networkInfo);
    return sR.tryRemoteandCatch(
      call: _uploadFileRemoteSource.uploadEventVideo(video,
          onUploadProgressCallback: onUploadProgressCallback),
      disableTimeOut: true,
      errorTitle: ErrorStrings.UPLOAD_FILE_ERROR,
    );
  }

  @override
  Future<Either<Failure, List<String>>> uploadImages(
      List<File> images, OnUploadProgressCallback onUploadProgressCallback) {
    ServiceRunner<Failure, List<String>> sR = ServiceRunner(_networkInfo);
    return sR.tryRemoteandCatch(
      call: _uploadFileRemoteSource.uploadListOfImages(images,
          onUploadProgressCallback: onUploadProgressCallback),
      disableTimeOut: true,
      errorTitle: ErrorStrings.UPLOAD_FILE_ERROR,
    );
  }
}
