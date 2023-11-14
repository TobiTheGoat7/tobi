import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:outt/constants/colors.dart';
import 'package:outt/features/common/clique_item_box.dart';
import 'package:outt/features/common/icons/asterisk_icon.dart';
import 'package:outt/features/common/profile_image_widget.dart';
import 'package:outt/features/common/text_widgets.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({super.key});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  bool isUp = false;

  @override
  void initState() {
    super.initState();
    //We can always use a TickerMixin
    //But this is more straight forward.
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isUp = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: AppColors.white,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          //Event Media Container.
          Container(
            height: size.height * 0.55,
            color: Colors.grey,
            child: Stack(
              children: [
                //Place Event Image Before the Title.
                Positioned(
                  bottom: size.height * 0.20,
                  left: size.width * 0.1,
                  child: Row(
                    children: [
                      Column(
                        children: const [
                          NormalText(
                            "Pet's Meet",
                            textColor: AppColors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w500,
                          ),
                          Gap(4.0),
                          NormalText(
                            "8 Person Event",
                            textColor: AppColors.white,
                          )
                        ],
                      ),
                      Gap(80.0.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0.w, vertical: 6.0.h),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Row(
                          children: const [
                            Icon(Icons.location_on_outlined),
                            Gap(2.0),
                            NormalText(
                              "Victoria Island",
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: size.height * 0.29,
            child: Container(
              height: size.height * 0.2,
              width: size.width,
              padding: const EdgeInsets.only(
                top: 12.5,
                left: 22.5,
                right: 22.5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0.r),
                color: AppColors.black,
              ),
              child: Material(
                color: AppColors.black,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(50.0.r),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: const [
                          AsteriskIcon(),
                          NormalText(
                            'Join Event',
                            textColor: AppColors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              height: isUp ? size.height * 0.42 : size.height * 0.49,
              width: size.width,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutBack,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0.r),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 40.0.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(60.h),
                      //
                      const NormalText(
                        'Attending',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        textColor: AppColors.black,
                      ),
                      //
                      Gap(13.h),

                      //List of Attendees.

                      SizedBox(
                        height: 70,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 6,
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 8.0.w),
                            itemBuilder: (context, index) {
                              return const Center(
                                child: ProfileImageWidget(),
                              );
                            }),
                      ),

                      Gap(20.0.h),

                      //So based on the type of event
                      //we can have
                      //different children widgets here
                      //This has been made to work with cliques for now.

                      //
                      Padding(
                        padding: EdgeInsets.only(right: 40.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            NormalText(
                              'Cliques',
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                              textColor: AppColors.black,
                            ),
                            NormalText(
                              '70+',
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                              textColor: AppColors.black,
                            ),
                          ],
                        ),
                      ),
                      Gap(13.h),
                      Wrap(
                        spacing: 14.0.w,
                        runSpacing: 14.0.h,
                        children:
                            List.generate(3, (index) => const CliqueItemBox()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
