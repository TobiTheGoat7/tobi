import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:outt/constants/colors.dart';
import 'package:outt/constants/extensions.dart';
import 'package:outt/features/common/app_video_widget.dart';
import 'package:outt/features/common/button_widget.dart';
import 'package:outt/features/common/text_widgets.dart';
import 'package:outt/features/file_picker/file_picker.dart';
import 'package:outt/features/file_upload/progress_indicator/upload_progress_bar.dart';
import 'package:outt/features/file_upload/state/upload_state.dart';
import 'package:outt/features/file_upload/state/upload_state_notifier.dart';

/// This handles the upload and recording of video
/// and returns the url of the uploaded video.
class CreateVideoUploadBox extends ConsumerStatefulWidget {
  /// Url returned by uploaded media.
  final void Function(String mediaUrl, File eventFile)? onUploadSuccess;
  const CreateVideoUploadBox({
    super.key,
    required this.onUploadSuccess,
  });

  @override
  ConsumerState<CreateVideoUploadBox> createState() =>
      _CreateVideoUploadBoxState();
}

class _CreateVideoUploadBoxState extends ConsumerState<CreateVideoUploadBox> {
  File? videoToUpload;

  @override
  Widget build(BuildContext context) {
    handleVideoUpload() {
      ///This will select the video
      ///TODO:Compress and crop the video to 60 Seconds and Smaller size
      ///Upload the video to a url
      ///return the video upload url.
      if (videoToUpload != null) {
        ref.read(uploadStateNotifierProvider.notifier).uploadEventVideo(
              videoToUpload!,
            );
      }
    }

    final state = ref.watch(uploadStateNotifierProvider);

    ref.listen(uploadStateNotifierProvider, (prev, next) {
      if (next is UploadStateFailure) {
        next.failure.showAlert(context);
      }
      if (next is UploadFileSuccess) {
        if (widget.onUploadSuccess != null) {
          widget.onUploadSuccess!(next.url, videoToUpload!);
        }
      }
    });

    return Stack(
      alignment: Alignment.topLeft,
      children: [
        if (videoToUpload != null)
          Container(
            height: 180.h,
            width: 370.w,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: AppVideoWidget(
              file: videoToUpload!,
              aspectRatio: 3.7 / 1.8,
            ),
          ),
        Container(
          height: 180.h,
          width: 370.w,
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 40.0.h),
          decoration: BoxDecoration(
            color: videoToUpload == null
                ? const Color(0xFFE9E9E9)
                : const Color(0x44E9E9E9),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: videoToUpload == null
                ? [
                    Column(
                      children: [
                        const NormalText(
                          'Upload Video (60Sec)',
                          fontSize: 10.0,
                        ),
                        const Gap(4.0),
                        AddMediaButton(
                          'Upload',
                          onPressed: () async {
                            if (videoToUpload == null) {
                              //Pick video from Gallery
                              videoToUpload = await pickFile(
                                  context: context,
                                  appFileType: AppFileType.video);
                              setState(() {});
                            }
                          },
                        ),
                        const Gap(4.0),
                        const NormalText(
                          'MP4,MOV,GIFs',
                          fontSize: 10.0,
                        )
                      ],
                    ),
                    Gap(60.0.w),
                    //Using the empty text and boxes to align correctly
                    //the contents of the two columns
                    Column(
                      children: [
                        const NormalText(
                          '',
                          fontSize: 10.0,
                        ),
                        const Gap(4.0),
                        AddMediaButton(
                          'Record',
                          onPressed: () async {
                            if (videoToUpload == null) {
                              videoToUpload = await getVideoFromCamera();
                              setState(() {});
                            }
                          },
                        ),
                        const Gap(4.0),
                        const NormalText(
                          '',
                          fontSize: 10.0,
                        )
                      ],
                    ),
                  ]
                : [
                    if (state is UploadingFileState)
                      UploadProgressBar(
                        progress: state.progress,
                      )
                    else if (state is UploadFileSuccess)
                      AddMediaButton(
                        'Uploaded',
                        onPressed: () {},
                        color: AppColors.doneGreen,
                        iconData: Icons.check,
                      )
                    else
                      AddMediaButton(
                        'Upload',
                        onPressed: () {
                          handleVideoUpload();
                        },
                      ),
                  ],
          ),
        ),
        if (videoToUpload != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    videoToUpload = null;
                  });
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
      ],
    );
  }
}
