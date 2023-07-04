import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:meditaion_music/internet_connection/connection_manager_controller.dart';
import 'package:meditaion_music/screens/bottom_bar.dart';
import 'package:meditaion_music/screens/welcome.dart';
import 'package:meditaion_music/utils/colors.dart';
import 'package:meditaion_music/utils/preferences/preference_manager.dart';





void main() async {
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreference().initialAppPreference();
  await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true);
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          initialBinding: ControllerBinding(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: 'Kanit', scaffoldBackgroundColor: ColorUtils.white),
          home: AppPreference().getBool("welcome")
              ? const BottomBar()
              : const IntroScreen(),
        );
      },
    );
  }
}
