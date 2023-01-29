import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:meditaion_music/screens/music_screen.dart';
import 'package:meditaion_music/utils/colors.dart';
import 'package:meditaion_music/utils/custom_text.dart';
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
                      StreamBuilder<SequenceState?>(
                        stream: player.value.sequenceStateStream,
                        builder: (context, snapshot) {
                          final state = snapshot.data;
                          if (state?.sequence.isEmpty ?? true) {
                            return const SizedBox();
                          }
                          final metadata =
                              state!.currentSource!.tag as MediaItem;
                          return AppPreference().getInt("ImageId") != null
                              ? QueryArtworkWidget(
                                  id:  11351 ,//AppPreference().getInt("ImageId") ?? 0,
                                  type: ArtworkType.AUDIO,
                                  artworkHeight: 70,
                                  artworkWidth: 60,
                                  artworkBorder: BorderRadius.circular(0),
                                  nullArtworkWidget: Container(
                                    width: 50,
                                    height: 70,
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: ColorUtils.textColor,borderRadius: BorderRadius.circular(8)),
                                    child: const Icon(Icons.music_note,
                                        color: ColorUtils.white),
                                  ))
                              : CachedNetworkImage(
                                  imageUrl:
                                      "${metadata.artUri}",
                                  fit: BoxFit.cover,
                                  width: 70,
                                  height: 60);
                        },
                      ),
                      const SizedBox(width: 10),
                      StreamBuilder<SequenceState?>(
                        stream: player.value.sequenceStateStream,
                        builder: (context, snapshot) {
                          final state = snapshot.data;
                          if (state?.sequence.isEmpty ?? true) {
                            return const SizedBox();
                          }
                          final metadata =
                              state!.currentSource!.tag as MediaItem;
                          return Expanded(
                            child: CustomText(
                                text: metadata.title.replaceAll('_', ' '),
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                                size: 17,
                                color: ColorUtils.white),
                          );
                        },
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
