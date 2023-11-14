import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:outt/constants/colors.dart';
import 'package:outt/constants/extensions.dart';
import 'package:outt/features/common/button_widget.dart';
import 'package:outt/features/common/image_from_file.dart';
import 'package:outt/features/common/text_widgets.dart';
import 'package:outt/features/file_picker/file_picker.dart';
import 'package:outt/features/file_upload/progress_indicator/upload_progress_bar.dart';
import 'package:outt/features/file_upload/state/upload_state.dart';
import 'package:outt/features/file_upload/state/upload_state_notifier.dart';

class AddMorePhotosBoxes extends StatefulWidget {
  final void Function(List<String> imageUrls)? imageUrlsCallBack;
  const AddMorePhotosBoxes({
    super.key,
    required this.greyFontColor,
    this.imageUrlsCallBack,
  });

  final Color greyFontColor;

  @override
  State<AddMorePhotosBoxes> createState() => _AddMorePhotosBoxesState();
}

class _AddMorePhotosBoxesState extends State<AddMorePhotosBoxes> {
  List<File> selectedImages = [];

  List<String> uploadedImageUrls = [];

  bool hasImageAtIndex(int index) {
    return selectedImages.length > index;
  }

  //
  @override
  Widget build(BuildContext context) {
    final BoxDecoration decoration = BoxDecoration(
      color: const Color(0xFFD9D9D9),
      borderRadius: BorderRadius.circular(5.0),
    );

    const space = Gap(4.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NormalText(
          '+ add more photos',
          fontSize: 10.0,
          textColor: widget.greyFontColor,
          fontWeight: FontWeight.w700,
        ),
        space,
        SizedBox(
          //changing this height will adjust the height of the boxes.
          height: 160.0.h,
          child: LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: (constraints.maxWidth / 2) - 2,
                      height: constraints.maxHeight,
                      clipBehavior: Clip.antiAlias,
                      decoration: decoration,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          hasImageAtIndex(0)
                              ? SizedBox(
                                  width: (constraints.maxWidth / 2) - 2,
                                  height: constraints.maxHeight,
                                  child: ImageFromFile(file: selectedImages[0]))
                              : const SizedBox.shrink(),
                          Center(
                            child: AddMediaButton(
                              'Add Photos',
                              width: 150.0.w,
                              onPressed: () async {
                                selectedImages = await getImagesFromDevice();
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    space,
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: (constraints.maxWidth / 4) - 4.0,
                                  height: (constraints.maxHeight / 2) - 2,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: decoration,
                                  child: hasImageAtIndex(1)
                                      ? ImageFromFile(file: selectedImages[1])
                                      : null,
                                ),
                                space,
                                Container(
                                  width: (constraints.maxWidth / 4) - 4.0,
                                  height: (constraints.maxHeight / 2) - 2,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: decoration,
                                  child: hasImageAtIndex(2)
                                      ? ImageFromFile(file: selectedImages[2])
                                      : null,
                                )
                              ],
                            ),
                            space,
                            Container(
                              height: (constraints.maxHeight / 2) - 2,
                              width: (constraints.maxWidth / 2) - 2.0,
                              decoration: decoration,
                              clipBehavior: Clip.antiAlias,
                              child: hasImageAtIndex(3)
                                  ? ImageFromFile(file: selectedImages[3])
                                  : null,
                            ),
                          ],
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            final state =
                                ref.watch(uploadStateNotifierProvider);
                            ref.listen(uploadStateNotifierProvider,
                                (previous, next) {
                              if (next is UploadStateFailure) {
                                next.failure.showAlert(context);
                              } else if (next is UploadImagesSuccess) {
                                uploadedImageUrls = next.urls;
                                if (widget.imageUrlsCallBack != null) {
                                  widget.imageUrlsCallBack!(uploadedImageUrls);
                                }
                              }
                            });
                            if (state is UploadingFileState) {
                              return UploadProgressBar(
                                  width: 130.0,
                                  height: 56.0.h,
                                  progress: state.progress);
                            } else if (state is UploadImagesSuccess) {
                              return const AddMediaButton(
                                'Uploaded',
                                iconData: Icons.check,
                                color: AppColors.doneGreen,
                              );
                            } else if (selectedImages.isNotEmpty) {
                              return AddMediaButton(
                                'Upload',
                                onPressed: () {
                                  ref
                                      .read(
                                          uploadStateNotifierProvider.notifier)
                                      .uploadImages(selectedImages);
                                },
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
