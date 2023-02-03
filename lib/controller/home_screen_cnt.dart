import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:meditaion_music/model/music_model.dart';

class HomeScreenCnt extends GetxController {
  Dio dio = Dio();
  late StreamSubscription streamSubscription;
  RxBool isDeviceConnected = false.obs;
  RxBool isAlertSet = false.obs;
  RxBool isLoading = false.obs;
  MusicResponseModel? musicModel;
  String basicUrl = 'https://drive.google.com/uc?export=view&id=';

  Future<void> getMusicData() async {
    try {
      isLoading.value = true;
      var response = await dio
          .get('https://sahilisamaliya.github.io/exam/meditation.json');

      // List<dynamic> musicList = response.data['data'];
      musicModel = MusicResponseModel.fromJson(response.data);
      musicModel?.recommended?.shuffle();
      // return musicList.map((e) => MusicData.fromJson(e)).toList();
      isLoading.value = false;
    } catch (e) {
      isAlertSet.value = true;
    }
    isLoading.value = false;
  }

  getConnectivity() =>
      streamSubscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected.value =
              await InternetConnectionChecker().hasConnection;
          print("isDeviceConnected.value ${isDeviceConnected.value}");
          if (!isDeviceConnected.value && isAlertSet.value == false) {
            isAlertSet.value = true;
          } else {
            isAlertSet.value = false;
          }
        },
      );
}
