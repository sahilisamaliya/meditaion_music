import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meditaion_music/screens/music_screen.dart';
import 'package:meditaion_music/utils/colors.dart';
import 'package:meditaion_music/utils/preferences/preference_manager.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    print("AppPreference ${AppPreference().getInt("ImageId")}");
    return StreamBuilder<PlayerState>(
      stream: player.value.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        return player.value.sequenceState == null
            ? const SizedBox.shrink()
            : InkWell(
                onTap: () => Get.to(() => const MusicScreen(isPlaying: true)),
                child: Container(
                  color: ColorUtils.purpleColor,
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppPreference().getInt("ImageId") != null
                          ? QueryArtworkWidget(
                              id: AppPreference().getInt("ImageId") ?? 0,
                              type: ArtworkType.AUDIO,
                              artworkHeight: 70,
                              artworkWidth: 60,
                              artworkBorder: BorderRadius.circular(0),
                              nullArtworkWidget: Container(
                                width: 60,
                                height: 70,
                                decoration: const BoxDecoration(
                                    color: ColorUtils.purpleColor),
                                child: const Icon(Icons.music_note,
                                    color: ColorUtils.white),
                              ))
                          : CachedNetworkImage(
                              imageUrl:
                                  "${player.value.sequenceState?.currentSource?.tag.artUri}",
                              fit: BoxFit.cover,
                              width: 70,
                              height: 60),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "${player.value.sequenceState?.currentSource?.tag.title}"
                              .replaceAll("_", " "),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 17),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      playing != true
                          ? IconButton(
                              icon: Icon(Icons.play_arrow_rounded,
                                  color: ColorUtils.white, size: 30.w),
                              iconSize: 64.0,
                              onPressed: () {
                                player.value.play();
                              },
                            )
                          : processingState != ProcessingState.completed
                              ? IconButton(
                                  icon: Icon(Icons.pause_rounded,
                                      color: ColorUtils.white, size: 25.w),
                                  iconSize: 64.0,
                                  onPressed: () {
                                    player.value.pause();
                                  },
                                )
                              : IconButton(
                                  icon: Icon(Icons.replay_rounded,
                                      color: ColorUtils.white, size: 25.w),
                                  iconSize: 64.0,
                                  onPressed: () => player.value.seek(
                                      Duration.zero,
                                      index:
                                          player.value.effectiveIndices!.first),
                                ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
