import 'package:flutter/material.dart ';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:meditaion_music/model/choose_topic_model.dart';
import 'package:meditaion_music/screens/home_screen.dart';
import 'package:meditaion_music/utils/colors.dart';
import 'package:meditaion_music/utils/customText.dart';

String greeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning';
  }
  if (hour < 17) {
    return 'Good Afternoon';
  }
  return 'Good Evening';
}

class ChooseTopic extends StatelessWidget {
  const ChooseTopic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.white,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/Union.png'),
                  fit: BoxFit.cover)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 65.h),
              CustomText(
                  text: greeting(),
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w300,
                  size: 16.sp,
                  color: ColorUtils.lightTextColor),
              RichText(
                text: TextSpan(
                  text: 'What Brings you\n',
                  style: TextStyle(
                      fontSize: 28.sp,
                      color: ColorUtils.textColor,
                      fontWeight: FontWeight.w700),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'to Silent Moon?',
                        style: TextStyle(
                            fontSize: 28.sp,
                            color: ColorUtils.textColor,
                            fontWeight: FontWeight.w300)),
                  ],
                ),
              ),
              CustomText(
                  text: 'choose a topic to focuse on:',
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w300,
                  size: 16.sp,
                  color: ColorUtils.lightTextColor),
              SizedBox(height: 30.h),
              Expanded(
                child: MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15.h,
                  crossAxisSpacing: 15.w,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: chooseTopicList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Get.to(const HomeScreen(),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
