import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:meditaion_music/model/music_model.dart';
import 'package:meditaion_music/screens/mini_player.dart';
import 'package:meditaion_music/screens/music_screen.dart';
import 'package:meditaion_music/utils/colors.dart';
import 'package:meditaion_music/utils/custom_text.dart';
import 'package:meditaion_music/utils/preferences/preference_manager.dart';

class AllMusicScreen extends StatefulWidget {
  final Recommended? recommended;

  const AllMusicScreen({Key? key, this.recommended}) : super(key: key);

  @override
  State<AllMusicScreen> createState() => _AllMusicScreenState();
}

class _AllMusicScreenState extends State<AllMusicScreen> {
  @override
  Widget build(BuildContext context) {
    print("player.value ${player.value.playing}");
    return Scaffold(
      bottomNavigationBar: const MiniPlayer(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: context.height / 2.5,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          '${widget.recommended?.image}'),
                      fit: BoxFit.fill),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsets.only(top: 50),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorUtils.white,
                    ),
                    child: const Icon(Icons.arrow_back_rounded, size: 30),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: "${widget.recommended?.title}",
                      color: ColorUtils.textColor,
                      size: 30.sp,
                      fontWeight: FontWeight.w600),
                  const SizedBox(height: 15),
                  CustomText(
                      text:
                          "Ease the mind into a restful night’s sleep  with these deep, amblent tones.",
                      color: ColorUtils.lightTextColor,
                      size: 14.sp,
                      fontWeight: FontWeight.w300),
                  const SizedBox(height: 15),
                  const Divider(height: 1, color: ColorUtils.dividerColor),
                  ListView.separated(
                    itemCount: widget.recommended!.musicData!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          await AppPreference().clearSharedPreferences();
                          Get.to(
                              () => MusicScreen(
                                  musicDataList: widget.recommended?.musicData,
                                  image: widget.recommended?.image,
                                  index: index),
                              transition: Transition.rightToLeft);
                        },
                        child: Row(
                          children: [
                            Obx(() => StreamBuilder<SequenceState?>(
                                  stream: player.value.sequenceStateStream,
                                  builder: (context, snapshot) {
                                    final state = snapshot.data;
                                    final metadata = state?.currentSource?.tag;
                                    print("metadata ${metadata}");
                                    return Container(
                                      height: 40.h,
                                      width: 40.w,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          color: ColorUtils.purpleColor,
                                          shape: BoxShape.circle),
                                      child: Icon(
                                    player.value.playing == true &&
                                                  metadata.title ==
                                                      widget
                                                          .recommended
                                                          ?.musicData?[index]
                                                          .musicName
                                              ? Icons.pause_rounded
                                              : Icons.play_arrow_rounded,
                                          color: ColorUtils.white,
                                          size: 25.w),
                                    );
                                  },
                                )),
                            const SizedBox(width: 20),
                            Expanded(
                              child: CustomText(
                                  text:
                                      "${widget.recommended?.musicData?[index].musicName}"
                                          .replaceAll('_', ' '),
                                  color: ColorUtils.textColor,
                                  size: 16.sp,
                                  overflow: TextOverflow.visible,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                          height: 1, color: ColorUtils.dividerColor);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
