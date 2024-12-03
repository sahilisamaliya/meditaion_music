import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditaion_music/model/choose_topic_model.dart';
import 'package:meditaion_music/screens/meditate.dart';
import 'package:meditaion_music/utils/colors.dart';
import 'package:meditaion_music/utils/custom_text.dart';

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
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/Union.png'),
                  fit: BoxFit.cover)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 65),
              // RichText(
              //   text: TextSpan(
              //     text: "${greeting()}\n",
              //     style: TextStyle(
              //         fontSize: 28,
              //         color: ColorUtils.textColor,
              //         fontWeight: FontWeight.w700),
              //     children: <TextSpan>[
              //       TextSpan(
              //           text: 'We Wish you have a good day',
              //           style: TextStyle(
              //               fontSize: 22,
              //               color: ColorUtils.textColor,
              //               fontWeight: FontWeight.w300)),
              //     ],
              //   ),
              // ),
              SizedBox(height: 5),
              CustomText(
                  text: 'choose a topic to focuse on:',
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w300,
                  size: 16,
                  color: ColorUtils.lightTextColor),
              SizedBox(height: 30),
              Expanded(
                child: MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: chooseTopicList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MeditateScreen()));
                      },
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
