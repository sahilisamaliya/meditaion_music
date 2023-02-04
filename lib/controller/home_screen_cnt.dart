import 'dart:async';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:meditaion_music/model/music_model.dart';

class HomeScreenCnt extends GetxController {
  Dio dio = Dio();
  RxBool noInternet = false.obs;
  RxBool isLoading = false.obs;
  MusicResponseModel? musicModel;
  String basicUrl = 'https://drive.google.com/uc?export=view&id=';

  Future<void> getMusicData() async {
    try {
      isLoading.value = true;
      noInternet.value = false;
      var response = await dio
          .get('https://sahilisamaliya.github.io/exam/meditation.json');

      // List<dynamic> musicList = response.data['data'];
      musicModel = MusicResponseModel.fromJson(response.data);
      musicModel?.recommended?.shuffle();
      // return musicList.map((e) => MusicData.fromJson(e)).toList();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      noInternet.value = true;
    }
    isLoading.value = false;
  }
}
