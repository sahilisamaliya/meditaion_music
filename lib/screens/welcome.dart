import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:meditaion_music/screens/bottom_bar.dart';
import 'package:meditaion_music/utils/colors.dart';
import 'package:meditaion_music/utils/custom_text.dart';
import 'package:meditaion_music/utils/preferences/preference_manager.dart';

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
          const SizedBox(height: 75),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: 'Welcome to Meditation\n ',
                  style: TextStyle(fontSize: 30, color: ColorUtils.white),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Silent Moon',
                        style: TextStyle(
                            fontSize: 30,
                            color: ColorUtils.white,
                            fontWeight: FontWeight.w200)),
                  ],
                ),
              )),
          const SizedBox(height: 15),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CustomText(
                text:
                    'Explore the app, Find some peace of mind to prepare for meditation.',
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w300,
                size: 16,
              )),
          const Spacer(),
          SvgPicture.asset('assets/images/Group.svg',
              alignment: Alignment.bottomCenter),
          Container(
            height: 150,
            color: ColorUtils.purpleColor,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Center(
              child: InkWell(
                onTap: () async {
                  await AppPreference().setBool("welcome", true);
                  Get.offAll(() => const BottomBar(),
                      transition: Transition.rightToLeft);
                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: ColorUtils.offWhite,
                      borderRadius: BorderRadius.circular(99)),
                  child: const Center(
                      child: CustomText(
                          text: 'GET STARTED',
                          fontWeight: FontWeight.w400,
                          size: 14,
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
