import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditaion_music/screens/music_screen.dart';
import 'package:meditaion_music/utils/colors.dart';
import 'package:meditaion_music/utils/preferences/preference_manager.dart';
import 'package:on_audio_query/on_audio_query.dart';

class OfflineMusic extends StatefulWidget {
  const OfflineMusic({Key? key}) : super(key: key);

  @override
  State<OfflineMusic> createState() => _OfflineMusicState();
}

class _OfflineMusicState extends State<OfflineMusic> {
  // bg color

  //define on audio plugin
  final OnAudioQuery _audioQuery = OnAudioQuery();

  //request permission from initStateMethod
  @override
  void initState() {
    super.initState();
    requestStoragePermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<SongModel>>(
        //default values
        future: _audioQuery.querySongs(
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, item) {
          //loading content indicator
          if (item.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //no songs found
          if (item.data!.isEmpty) {
            return const Center(
              child: Text("No Songs Found"),
            );
          }

          return ListView.builder(
              itemCount: item.data!.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.only(top: 15.0, left: 12.0, right: 16.0),
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  decoration: BoxDecoration(
                      color: ColorUtils.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, blurRadius: 5.0),
                      ]),
                  child: ListTile(
                    textColor: Colors.white,
                    title: Text(
                      item.data![index].title,
                      style: TextStyle(color: ColorUtils.blackColor),
                    ),
                    // subtitle: Text(
                    //   item.data![index].displayName,
                    //   style: const TextStyle(
                    //     color: Colors.white60,
                    //   ),
                    // ),
                    leading: QueryArtworkWidget(
                        id: item.data![index].id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorUtils.purpleColor),
                          child: const Icon(Icons.music_note),
                        )),
                    onTap: () async {
                      await AppPreference()
                          .setInt("ImageId", item.data?[index].id ?? 0);
                      Get.to(() =>
                          MusicScreen(localData: item.data, localIndex: index));
                    },
                  ),
                );
              });
        },
      ),
    );
  }

  //define a toast method
  void toast(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    ));
  }

  void requestStoragePermission() async {
    //only if the platform is not web, coz web have no permissions
    bool permissionStatus = await _audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await _audioQuery.permissionsRequest();
    }
    //ensure build method is called
    setState(() {});
  }
}
