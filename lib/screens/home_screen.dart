import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:meditaion_music/model/choose_topic_model.dart';
import 'package:meditaion_music/screens/music_screen.dart';
import 'package:meditaion_music/utils/colors.dart';
import 'package:meditaion_music/utils/customText.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 45.h),
              CustomText(
                  text: "Meditate",
                  color: ColorUtils.textColor,
                  size: 28.sp,
                  fontWeight: FontWeight.w600),
              CustomText(
                  text:
                      "we can learn how to recognize when our minds are doing their normal everyday acrobatics.",
                  color: ColorUtils.lightTextColor,
                  size: 15.sp,
                  fontWeight: FontWeight.w300),
              SizedBox(height: 25.h),
              Container(
                height: 95,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                    color: ColorUtils.skinColor,
                    borderRadius: BorderRadius.circular(10.r),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/Mask_Group.png'),
                        fit: BoxFit.cover)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text: "Daily Calm",
                        color: ColorUtils.textColor,
                        size: 18.sp,
                        fontWeight: FontWeight.w600),
                    Container(
                      height: 40.h,
                      width: 40.w,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: ColorUtils.textColor, shape: BoxShape.circle),
                      child: SvgPicture.asset('assets/images/play.svg',
                          height: 11.h, width: 11.w),
                    )
                  ],
                ),
              ),
              MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 15.h,
                crossAxisSpacing: 15.w,
                padding: EdgeInsets.symmetric(vertical: 15.h),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: chooseTopicList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => Get.to(const MusicScreen(),
                        transition: Transition.rightToLeft),
                    child: Container(
                      width: 150.w,
                      decoration: BoxDecoration(
                          color: chooseTopicList[index].color,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          SvgPicture.asset("${chooseTopicList[index].image}"),
                          Container(
                              height: 60.h,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: CustomText(
                                  text: '${chooseTopicList[index].name}',
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w600,
                                  size: 16.sp,
                                  color: chooseTopicList[index].textColor)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
