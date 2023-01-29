import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:meditaion_music/music_slider.dart';
import 'package:meditaion_music/model/music_model.dart';
import 'package:meditaion_music/utils/colors.dart';
import 'package:meditaion_music/utils/custom_text.dart';
import 'package:meditaion_music/utils/preferences/preference_manager.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart' as rx;

class MusicScreen extends StatefulWidget {
  final String? musicUrl;
  final String? title;
  final String? image;
  final List<MusicData>? musicDataList;
  final int? index;
  final bool? isPlaying;
  final int? localIndex;
  final List<SongModel>? localData;

  const MusicScreen({
    Key? key,
    this.musicUrl,
    this.title,
    this.image,
    this.musicDataList,
    this.index,
    this.isPlaying = false,
    this.localIndex,
    this.localData,
  }) : super(key: key);

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

Rx<AudioPlayer> player = AudioPlayer().obs;

class _MusicScreenState extends State<MusicScreen>
    with SingleTickerProviderStateMixin {
  static int _nextMediaId = 0;
  AnimationController? _controller;

  @override
  void initState() {
    if (widget.isPlaying == false) {
      _init();
    }
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.3,
      duration: const Duration(seconds: 3),
    )..repeat();
    super.initState();
  }

  Future<void> _init() async {
    final AudioSource playlist;
    try {
      if (widget.musicUrl?.isNotEmpty ?? false) {
        List<String>? bits = widget.musicUrl?.split("/");
        String lastWord = bits![bits.length - 2];
        playlist = AudioSource.uri(
            Uri.parse('https://drive.google.com/uc?export=view&id=$lastWord'),
            tag: MediaItem(
              id: '${_nextMediaId++}',
              title: widget.title ?? '',
              artUri: Uri.parse(widget.image ??
                  "https://media.istockphoto.com/id/1175435360/vector/music-note-icon-vector-illustration.jpg?s=612x612&w=0&k=20&c=R7s6RR849L57bv_c7jMIFRW4H87-FjLB8sqZ08mN0OU="),
            ));
        await player.value.setAudioSource(playlist);
      } else {
        if (widget.localData == null) {
          playlist = ConcatenatingAudioSource(
            children: widget.musicDataList!.map(
              (e) {
                List<String>? bits = e.musicUrl?.split("/");
                String lastWord = bits![bits.length - 2];
                return AudioSource.uri(
                    Uri.parse(
                        'https://drive.google.com/uc?export=view&id=$lastWord'),
                    tag: MediaItem(
                      id: '${_nextMediaId++}',
                      title: e.musicName ?? '',
                      artUri: Uri.parse(widget.image ??
                          'https://img.freepik.com/free-vector/organic-flat-people-meditating-illustration_23-2148906556.jpg?w=2000'),
                    ));
              },
            ).toList(),
          );
          await player.value
              .setAudioSource(playlist, initialIndex: widget.index);
        } else {
          playlist = ConcatenatingAudioSource(
            children: widget.localData!.map(
              (e) {
                return AudioSource.uri(Uri.parse('${e.uri}'),
                    tag: MediaItem(
                      id: '${_nextMediaId++}',
                      title: e.title,
                      artUri: Uri.parse(widget.image ??
                          'https://media.istockphoto.com/id/1175435360/vector/music-note-icon-vector-illustration.jpg?s=612x612&w=0&k=20&c=R7s6RR849L57bv_c7jMIFRW4H87-FjLB8sqZ08mN0OU='),
                    ));
              },
            ).toList(),
          );
          await player.value
              .setAudioSource(playlist, initialIndex: widget.localIndex);
        }
      }
      await player.value.play();
    } catch (e) {
      // Catch load errors: 404, invalid url ...
      print("Error loading playlist: $e");
      Get.back();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    // player.dispose();
    super.dispose();
  }

  Stream<PositionData> get _positionDataStream =>
      rx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player.value.positionStream,
          player.value.bufferedPositionStream,
          player.value.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/music_background.png'),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 50.h,
                      width: 50.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorUtils.white,
                      ),
                      child: const Icon(Icons.close, size: 30),
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      _buildCircularContainer(250),
                      _buildCircularContainer(300),
                      StreamBuilder<SequenceState?>(
                        stream: player.value.sequenceStateStream,
                        builder: (context, snapshot) {
                          final state = snapshot.data;
                          final metadata = state?.currentSource?.tag;
                          return AppPreference().getInt("ImageId") == null
                              ? CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      "${metadata.artUri}"),
                                  radius: 90)
                              : QueryArtworkWidget(
                                  id: 11351,
                                  //AppPreference().getInt("ImageId") ?? 0
                                  type: ArtworkType.AUDIO,
                                  artworkHeight: 180,
                                  artworkWidth: 180,
                                  artworkColor: Colors.white,
                                  artworkBorder: BorderRadius.circular(99),
                                  nullArtworkWidget: Container(
                                    width: 180,
                                    height: 180,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ColorUtils.textColor),
                                    child: const Icon(Icons.music_note,
                                        color: Colors.white, size: 60),
                                  ));
                        },
                      )
                    ],
                  ),
                ),
                StreamBuilder<SequenceState?>(
                  stream: player.value.sequenceStateStream,
                  builder: (context, snapshot) {
                    final state = snapshot.data;
                    if (state?.sequence.isEmpty ?? true) {
                      return const SizedBox();
                    }
                    final metadata = state!.currentSource!.tag as MediaItem;
                    return Center(
                      child: CustomText(
                          text: metadata.title.replaceAll('_', ' '),
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          size: 30,
                          color: ColorUtils.textColor),
                    );
                  },
                ),
                SizedBox(height: 40.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StreamBuilder<PositionData>(
                      stream: _positionDataStream,
                      builder: (context, snapshot) {
                        final playerState = snapshot.data;
                        return InkWell(
                          onTap: () async {
                            if (playerState!.position >=
                                const Duration(seconds: 10)) {
                              await player.value.seek(Duration(
                                  seconds: int.parse(playerState
                                          .position.inSeconds
                                          .toString()) -
                                      10));
                            }
                          },
                          child: const Icon(Icons.replay_10_rounded,
                              size: 56, color: ColorUtils.greyLight),
                        );
                      },
                    ),
                    InkWell(
                      onTap: player.value.play,
                      child: Container(
                          // height: 100.h,
                          // width: 100.w,
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                              color: ColorUtils.greyLight,
                              shape: BoxShape.circle),
                          child: StreamBuilder<PlayerState>(
                            stream: player.value.playerStateStream,
                            builder: (context, snapshot) {
                              final playerState = snapshot.data;
                              final processingState =
                                  playerState?.processingState;
                              final playing = playerState?.playing;
                              return Container(
                                height: 70.h,
                                width: 70.w,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    color: ColorUtils.textColor,
                                    shape: BoxShape.circle),
                                child: processingState ==
                                            ProcessingState.loading ||
                                        processingState ==
                                            ProcessingState.buffering
                                    ? const CircularProgressIndicator(
                                        color: ColorUtils.white)
                                    : playing != true
                                        ? IconButton(
                                            icon: Icon(Icons.play_arrow_rounded,
                                                color: ColorUtils.white,
                                                size: 45.w),
                                            iconSize: 64.0,
                                            onPressed: () {
                                              player.value.play();
                                              _controller?.repeat();
                                              // setState(() => _isPlaying = true);
                                            },
                                          )
                                        : processingState !=
                                                ProcessingState.completed
                                            ? IconButton(
                                                icon: Icon(Icons.pause_rounded,
                                                    color: ColorUtils.white,
                                                    size: 37.w),
                                                iconSize: 64.0,
                                                onPressed: () {
                                                  player.value.pause();
                                                  _controller?.reset();
                                                  // setState(() =>
                                                  //     _isPlaying = !_isPlaying);
                                                },
                                              )
                                            : IconButton(
                                                icon: Icon(Icons.replay_rounded,
                                                    color: ColorUtils.white,
                                                    size: 37.w),
                                                iconSize: 64.0,
                                                onPressed: () => player.value
                                                    .seek(Duration.zero,
                                                        index: player
                                                            .value
                                                            .effectiveIndices!
                                                            .first),
                                              ),
                              );
                            },
                          )),
                    ),
                    StreamBuilder<PositionData>(
                      stream: _positionDataStream,
                      builder: (context, snapshot) {
                        final playerState = snapshot.data;
                        return InkWell(
                          onTap: () async {
                            if (playerState!.position.inSeconds <=
                                playerState.duration.inSeconds) {
                              await player.value.seek(Duration(
                                  seconds: int.parse(playerState
                                          .position.inSeconds
                                          .toString()) +
                                      10));
                            }
                          },
                          child: const Icon(Icons.forward_10_rounded,
                              size: 56, color: ColorUtils.greyLight),
                        );
                      },
                    ),
                  ],
                ),
                StreamBuilder<PositionData>(
                  stream: _positionDataStream,
                  builder: (context, snapshot) {
                    final positionData = snapshot.data;
                    return SeekBar(
                      duration: positionData?.duration ?? Duration.zero,
                      position: positionData?.position ?? Duration.zero,
                      bufferedPosition:
                          positionData?.bufferedPosition ?? Duration.zero,
                      onChangeEnd: (newPosition) {
                        player.value.seek(newPosition);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircularContainer(double radius) {
    return AnimatedBuilder(
      animation: CurvedAnimation(
          parent: _controller!, curve: Curves.fastLinearToSlowEaseIn),
      builder: (context, child) {
        return Container(
          width: _controller!.value * radius,
          height: _controller!.value * radius,
          decoration: BoxDecoration(
              color: ColorUtils.textColor.withOpacity(1 - _controller!.value),
              shape: BoxShape.circle),
        );
      },
    );
  }
}
