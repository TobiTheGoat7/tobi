import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:outt/features/file_upload/data/repository.dart';
import 'package:outt/features/file_upload/state/upload_state.dart';

final uploadStateNotifierProvider =
    StateNotifierProvider.autoDispose<UploadStateNotifier, UploadState>(
  (ref) {
    return UploadStateNotifier(ref);
  },
);

class UploadStateNotifier extends StateNotifier<UploadState> {
  final UploadFileRepository _uploadFileRepository;
  UploadStateNotifier(Ref ref)
      : _uploadFileRepository = ref.read(uploadFileRepositoryProvider),
        super(InitialUploadState());

  Future<void> uploadEventVideo(File file) async {
    state = UploadingFileState(0);

    final uploadOrError =
        await _uploadFileRepository.uploadEventVideo(file, (value, total) {
      state = UploadingFileState(value / total);
    });

    state = uploadOrError.fold(
      (l) => UploadStateFailure(l),
      (r) => UploadFileSuccess(r),
    );
  }

  Future<void> uploadImages(List<File> files) async {
    state = UploadingFileState(0);

    final uploadOrError =
        await _uploadFileRepository.uploadImages(files, (value, total) {
      state = UploadingFileState(value / total);
    });

    state = uploadOrError.fold(
      (l) => UploadStateFailure(l),
      (r) => UploadImagesSuccess(r),
    );
  }
}
