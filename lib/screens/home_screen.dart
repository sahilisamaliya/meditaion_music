import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:meditaion_music/controller/home_screen_cnt.dart';
import 'package:meditaion_music/internet_connection/connection_manager_controller.dart';
import 'package:meditaion_music/internet_connection/no_internet_screen.dart';
import 'package:meditaion_music/screens/all_music_screen.dart';
import 'package:meditaion_music/screens/music_screen.dart';
import 'package:meditaion_music/utils/colors.dart';
import 'package:meditaion_music/utils/custom_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  final controller = Get.put(HomeScreenCnt());
  final cnt = Get.put(ConnectionManagerController());

  @override
  void initState() {
    controller.getMusicData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(color: ColorUtils.purpleColor))
            : controller.noInternet.value
                ? const NoInternetScreen()
                : Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/Union.png'),
                            fit: BoxFit.cover)),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedContainer(
                            height: cnt.connectionType.value ? 40 : 0,
                            decoration: const BoxDecoration(
                              color: ColorUtils.textColor,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(8),
                                    bottomLeft: Radius.circular(8))),
                            duration: const Duration(seconds: 1),
                            child: const Center(
                              child: CustomText(
                                  text: 'No Internet',
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w400,
                                  size: 15,
                                  color: ColorUtils.white),
                            ),
                          ),
                          SizedBox(height: 65.h),
                          RichText(
                            text: TextSpan(
                              text: "${greeting()}\n",
                              style: TextStyle(
                                  fontSize: 28.sp,
                                  color: ColorUtils.textColor,
                                  fontWeight: FontWeight.w700),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'We Wish you have a good day',
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        color: ColorUtils.lightTextColor,
                                        fontWeight: FontWeight.w300)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 210,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorUtils.purpleColor,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: SvgPicture.asset(
                                              'assets/images/basics.svg')),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: CustomText(
                                            text: 'Basics',
                                            textAlign: TextAlign.start,
                                            fontWeight: FontWeight.w600,
                                            size: 18.sp,
                                            color: ColorUtils.white),
                                      ),
                                      const SizedBox(width: 10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: CustomText(
                                            text: 'MUSIC',
                                            textAlign: TextAlign.start,
                                            fontWeight: FontWeight.w400,
                                            size: 11.sp,
                                            color: ColorUtils.white),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                text:
                                                    '${controller.musicModel?.basics?.musicLength} MIN',
                                                textAlign: TextAlign.start,
                                                fontWeight: FontWeight.w400,
                                                size: 11.sp,
                                                color: ColorUtils.white),
                                            InkWell(
                                              onTap: () => Get.to(
                                                  () => MusicScreen(
                                                      musicUrl: controller
                                                          .musicModel
                                                          ?.basics
                                                          ?.musicUrl,
                                                      title: "Basics",
                                                      image:
                                                          "https://media.istockphoto.com/id/1313456479/photo/man-and-soul-yoga-lotus-pose-meditation-on-nebula-galaxy-background.jpg?b=1&s=170667a&w=0&k=20&c=p_EQSpHfArCOvibKe7ypoyFZERAiEFHuFx4weXiHd0g="),
                                                  transition:
                                                      Transition.rightToLeft),
                                              child: Container(
                                                height: 35,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                    color: ColorUtils.offWhite,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            99.r)),
                                                child: Center(
                                                    child: CustomText(
                                                        text: 'START',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        size: 14.sp,
                                                        color: ColorUtils
                                                            .blackColor)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  height: 210,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorUtils.yellowColor,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10)),
                                            child: SvgPicture.asset(
                                                'assets/images/relaxsion.svg')),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: CustomText(
                                            text: 'Relaxation',
                                            textAlign: TextAlign.start,
                                            fontWeight: FontWeight.w600,
                                            size: 18.sp,
                                            color: ColorUtils.textColor),
                                      ),
                                      const SizedBox(width: 10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: CustomText(
                                            text: 'MUSIC',
                                            textAlign: TextAlign.start,
                                            fontWeight: FontWeight.w400,
                                            size: 11.sp,
                                            color: ColorUtils.textColor),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                text:
                                                    '${controller.musicModel?.relaxation?.musicLength} MIN',
                                                textAlign: TextAlign.start,
                                                fontWeight: FontWeight.w400,
                                                size: 11.sp,
                                                color: ColorUtils.textColor),
                                            InkWell(
                                              onTap: () => Get.to(
                                                  () => MusicScreen(
                                                      musicUrl: controller
                                                          .musicModel
                                                          ?.relaxation
                                                          ?.musicUrl,
                                                      title: "Relaxation",
                                                      image:
                                                          "https://media.istockphoto.com/id/1313456479/photo/man-and-soul-yoga-lotus-pose-meditation-on-nebula-galaxy-background.jpg?b=1&s=170667a&w=0&k=20&c=p_EQSpHfArCOvibKe7ypoyFZERAiEFHuFx4weXiHd0g="),
                                                  transition:
                                                      Transition.rightToLeft),
                                              child: Container(
                                                height: 35,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                    color: ColorUtils.textColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            99.r)),
                                                child: Center(
                                                    child: CustomText(
                                                        text: 'START',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        size: 14.sp,
                                                        color:
                                                            ColorUtils.white)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 40),
                          CustomText(
                              text: 'Recommended for you',
                              fontWeight: FontWeight.w400,
                              size: 24.sp,
                              color: ColorUtils.textColor),
                          const SizedBox(height: 20),
                          GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 5 / 5.8,
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 15),
                              itemCount:
                                  controller.musicModel?.recommended?.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return GestureDetector(
                                  onTap: () => Get.to(
                                      () => AllMusicScreen(
                                          recommended: controller
                                              .musicModel?.recommended?[index]),
                                      transition: Transition.rightToLeft),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 130,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: ColorUtils.yellowColor,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                                image: CachedNetworkImageProvider(
                                                    '${controller.musicModel?.recommended?[index].image}'),
                                                fit: BoxFit.cover)),
                                      ),
                                      // SizedBox(height: 5),
                                      CustomText(
                                          text:
                                              '${controller.musicModel?.recommended?[index].title}',
                                          fontWeight: FontWeight.w600,
                                          size: 16.sp,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          color: ColorUtils.textColor),
                                      CustomText(
                                          text: 'MEDITATION 3-10 MIN',
                                          fontWeight: FontWeight.w400,
                                          size: 11.sp,
                                          color: ColorUtils.lightTextColor),
                                    ],
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
      )),
    );
  }
}
