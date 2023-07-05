import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditaion_music/model/choose_topic_model.dart';
import 'package:meditaion_music/utils/colors.dart';
import 'package:meditaion_music/utils/custom_text.dart';

class MeditateScreen extends StatefulWidget {
  const MeditateScreen({Key? key}) : super(key: key);

  @override
  State<MeditateScreen> createState() => _MeditateScreenState();
}

class _MeditateScreenState extends State<MeditateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 45),
              CustomText(
                  text: "Meditate",
                  color: ColorUtils.textColor,
                  size: 28,
                  fontWeight: FontWeight.w600),
              CustomText(
                  text:
                      "we can learn how to recognize when our minds are doing their normal everyday acrobatics.",
                  color: ColorUtils.lightTextColor,
                  size: 15,
                  fontWeight: FontWeight.w300),
              SizedBox(height: 25),
              Container(
                height: 95,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: ColorUtils.skinColor,
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/Mask_Group.png'),
                        fit: BoxFit.cover)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text: "Daily Calm",
                        color: ColorUtils.textColor,
                        size: 18,
                        fontWeight: FontWeight.w600),
                    Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: ColorUtils.textColor, shape: BoxShape.circle),
                      child: SvgPicture.asset('assets/images/play.svg',
                          height: 11, width: 11),
                    )
                  ],
                ),
              ),
              MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 15),
                itemCount: chooseTopicList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    // onTap: () => Get.to(const MusicScreen(),
                    //     transition: Transition.rightToLeft),
                    child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                          color: chooseTopicList[index].color,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          SvgPicture.asset("${chooseTopicList[index].image}"),
                          Container(
                              height: 60,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: CustomText(
                                  text: '${chooseTopicList[index].name}',
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w600,
                                  size: 16,
                                  color: chooseTopicList[index].textColor)),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    ));
  }
}
