import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:meditaion_music/controller/bottom_bar_cnt.dart';
import 'package:meditaion_music/screens/home_screen.dart';
import 'package:meditaion_music/screens/home_screen2.dart';
import 'package:meditaion_music/utils/colors.dart';
import 'package:meditaion_music/utils/customText.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final cnt = Get.put(BottomBarCnt());
  final pages = [
    const HomeScreen2(),
    const Center(child: Text("Coming Soon")),
    const HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: pages[cnt.pageIndex.value],
          bottomNavigationBar: Container(
            height: 80,
            decoration: const BoxDecoration(color: ColorUtils.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () => cnt.pageIndex.value = 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 46,
                        width: 46,
                        padding: const EdgeInsets.all(11),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: cnt.pageIndex.value == 0
                                ? ColorUtils.purpleColor
                                : ColorUtils.white),
                        child: SvgPicture.asset(
                          'assets/images/home.svg',
                          color: cnt.pageIndex.value == 0
                              ? ColorUtils.white
                              : ColorUtils.lightTextColor,
                        ),
                      ),
                      CustomText(
                          text: 'Home',
                          fontWeight: FontWeight.w400,
                          size: 14.sp,
                          color: cnt.pageIndex.value == 0
                              ? ColorUtils.purpleColor
                              : ColorUtils.lightTextColor)
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => cnt.pageIndex.value = 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 46,
                        width: 46,
                        padding: const EdgeInsets.all(11),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: cnt.pageIndex.value == 1
                                ? ColorUtils.purpleColor
                                : ColorUtils.white),
                        child: SvgPicture.asset(
                          'assets/images/sleep.svg',
                          color: cnt.pageIndex.value == 1
                              ? ColorUtils.white
                              : ColorUtils.lightTextColor,
                        ),
                      ),
                      CustomText(
                          text: 'Sleep',
                          fontWeight: FontWeight.w400,
                          size: 14.sp,
                          color: cnt.pageIndex.value == 1
                              ? ColorUtils.purpleColor
                              : ColorUtils.lightTextColor)
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => cnt.pageIndex.value = 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 46,
                        width: 46,
                        padding: const EdgeInsets.all(11),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: cnt.pageIndex.value == 2
                                ? ColorUtils.purpleColor
                                : ColorUtils.white),
                        child: SvgPicture.asset(
                          'assets/images/meditate.svg',
                          color: cnt.pageIndex.value == 2
                              ? ColorUtils.white
                              : ColorUtils.lightTextColor,
                        ),
                      ),
                      CustomText(
                          text: 'Meditate',
                          fontWeight: FontWeight.w400,
                          size: 14.sp,
                          color: cnt.pageIndex.value == 2
                              ? ColorUtils.purpleColor
                              : ColorUtils.lightTextColor)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
