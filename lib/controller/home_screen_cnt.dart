import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:meditaion_music/model/music_model.dart';

class HomeScreenCnt extends GetxController {
  Dio dio = Dio();

  RxBool isLoading = false.obs;
  MusicResponseModel? musicModel;

  String basicUrl = 'https://drive.google.com/uc?export=view&id=';

  Future<void> getMusicData() async {
    try {
      isLoading.value = true;
      var response = await dio
          .get('https://sahilisamaliya.github.io/exam/meditation.json');

      // List<dynamic> musicList = response.data['data'];

      print(response.data);
      musicModel = MusicResponseModel.fromJson(response.data);

      // return musicList.map((e) => MusicData.fromJson(e)).toList();
      isLoading.value = false;
    } catch (e) {
      rethrow;
    }
    isLoading.value = false;
  }
}
