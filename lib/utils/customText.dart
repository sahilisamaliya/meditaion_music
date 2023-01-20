import 'package:flutter/material.dart';
import 'package:meditaion_music/utils/colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final double? height;

  const CustomText({super.key,
    required this.text,
    this.size,
    this.fontWeight,
    this.color, this.textAlign, this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          fontSize:size,
          height: height,
          fontWeight: fontWeight,
          color: color ?? ColorUtils.white),
    );
  }
}