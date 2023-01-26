import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:meditaion_music/screens/bottom_bar.dart';
import 'package:meditaion_music/screens/choose_topic.dart';
import 'package:meditaion_music/screens/home_screen2.dart';
import 'package:meditaion_music/utils/colors.dart';
import 'package:meditaion_music/utils/customText.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/welcome.png'),
              fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 75.h),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Welcome to Meditation\n ',
                  style: TextStyle(fontSize: 30.sp, color: ColorUtils.white),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Silent Moon',
                        style: TextStyle(
                            fontSize: 30.sp,
                            color: ColorUtils.white,
                            fontWeight: FontWeight.w200)),
                  ],
                ),
              )),
          SizedBox(height: 15.h),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomText(
                text:
                    'Explore the app, Find some peace of mind to prepare for meditation.',
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w300,
                size: 16.sp,
              )),
          const Spacer(),
          SvgPicture.asset('assets/images/Group.svg',
              alignment: Alignment.bottomCenter),
          Container(
            height: 150.h,
            color: ColorUtils.purpleColor,
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Center(
              child: InkWell(
                onTap: () => Get.to(() => const BottomBar(),
                    transition: Transition.rightToLeft),
                child: Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                      color: ColorUtils.offWhite,
                      borderRadius: BorderRadius.circular(99.r)),
                  child: Center(
                      child: CustomText(
                          text: 'GET STARTED',
                          fontWeight: FontWeight.w400,
                          size: 14.sp,
                          color: ColorUtils.blackColor)),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
