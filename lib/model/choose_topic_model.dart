import 'package:flutter/material.dart';
import 'package:meditaion_music/utils/colors.dart';

class ChooseTopicModel {

  final String? image;
  final String? name;
  final Color? color;
  final Color textColor;

  ChooseTopicModel({this.name, this.color, this.image,this.textColor = ColorUtils.offWhite});

}

List<ChooseTopicModel> chooseTopicList = <ChooseTopicModel>[
  ChooseTopicModel(
    color: ColorUtils.purpleColor,
    image: "assets/images/reduce_stress.svg",
    name: "Reduce Stress"
  ),
  ChooseTopicModel(
      color: ColorUtils.redColor,
      image: "assets/images/Improve_Performanee.svg",
      name: "Improve Performanee"
  ),
  ChooseTopicModel(
      color: ColorUtils.brownColor,
      image: "assets/images/increase_happiness.svg",
      name: "Increase Happiness",
      textColor: ColorUtils.textColor
  ),
  ChooseTopicModel(
      color: ColorUtils.yellowColor,
      image: "assets/images/Reduce_Anxiety.svg",
      name: "Reduce Anxiety",
    textColor: ColorUtils.textColor
  ),
  ChooseTopicModel(
      color: ColorUtils.greenColor,
      image: "assets/images/Personal_Growth.svg",
      name: "Personal Growth"
  ),
  ChooseTopicModel(
      color: ColorUtils.textColor,
      image: "assets/images/Better_sleep.svg",
      name: "Better Sleep"
  ),
];