import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meditaion_music/controller/home_screen_cnt.dart';
import 'package:meditaion_music/utils/colors.dart';
import 'package:meditaion_music/utils/custom_text.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cnt = Get.put(HomeScreenCnt());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(
                text: 'No Internet',
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w400,
                size: 20,
                color: ColorUtils.textColor),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () async {
                await cnt.getMusicData();
              },
              child: Container(
                height: 45.h,
                width: 200.w,
                decoration: BoxDecoration(
                    color: ColorUtils.offWhite,
                    borderRadius: BorderRadius.circular(99.r)),
                child: Center(
                    child: CustomText(
                        text: 'Retry',
                        fontWeight: FontWeight.w400,
                        size: 14.sp,
                        color: ColorUtils.blackColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
