import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:meditaion_music/common.dart';
import 'package:meditaion_music/utils/colors.dart';
import 'package:meditaion_music/utils/customText.dart';
import 'package:rxdart/rxdart.dart' as rx;

class MusicScreen extends StatefulWidget {
  const MusicScreen({Key? key}) : super(key: key);

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen>
    with SingleTickerProviderStateMixin {
  static int _nextMediaId = 0;
  late AudioPlayer _player;
  AnimationController? _controller;
  bool _isPlaying = true;
  final _playlist = ConcatenatingAudioSource(children: [
    ClippingAudioSource(
      start: const Duration(seconds: 60),
      end: const Duration(seconds: 90),
      child: AudioSource.uri(Uri.parse(
          "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3")),
      tag: MediaItem(
        id: '${_nextMediaId++}',
        album: "Science Friday",
        title: "A Salute To Head-Scratching Science (30 seconds)",
        artUri: Uri.parse(
            "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg"),
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3"),
      tag: MediaItem(
        id: '${_nextMediaId++}',
        album: "Science Friday",
        title: "A Salute To Head-Scratching Science",
        artUri: Uri.parse(
            "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg"),
      ),
    ),
    AudioSource.uri(
      Uri.parse("https://s3.amazonaws.com/scifri-segments/scifri201711241.mp3"),
      tag: MediaItem(
        id: '${_nextMediaId++}',
        album: "Science Friday",
        title: "From Cat Rheology To Operatic Incompetence",
        artUri: Uri.parse(
            "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg"),
      ),
    ),
    AudioSource.uri(
      Uri.parse("asset:///audio/nature.mp3"),
      tag: MediaItem(
        id: '${_nextMediaId++}',
        album: "Public Domain",
        title: "Nature Sounds",
        artUri: Uri.parse(
            "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg"),
      ),
    ),
  ]);
  int _addedCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.3,
      duration: Duration(seconds: 3),
    )..repeat();

    _player = AudioPlayer();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      await _player.setAudioSource(_playlist);
      await _player.play();
    } catch (e, stackTrace) {
      // Catch load errors: 404, invalid url ...
      print("Error loading playlist: $e");
      print(stackTrace);
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Stream<PositionData> get _positionDataStream =>
      rx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
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
                image: AssetImage('assets/images/music_background.png'))),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30.h),
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
                  height: 250,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      _buildCircularContainer(200),
                      _buildCircularContainer(250),
                      _buildCircularContainer(300),
                      const Align(
                          child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/welcome.png"),
                              radius: 72)),
                    ],
                  ),
                ),
                Center(
                  child: CustomText(
                      text: 'Focus Attention',
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w600,
                      size: 34.sp,
                      color: ColorUtils.textColor),
                ),
                SizedBox(height: 40.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {},
                        child: const Icon(Icons.replay_10_rounded,
                            size: 56, color: ColorUtils.greyLight)),
                    InkWell(
                      onTap: _player.play,
                      child: Container(
                          height: 100.h,
                          width: 100.w,
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                              color: ColorUtils.greyLight,
                              shape: BoxShape.circle),
                          child: StreamBuilder<PlayerState>(
                            stream: _player.playerStateStream,
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
                                        color: ColorUtils.white,
                                      )
                                    : playing != true
                                        ? IconButton(
                                            icon: Icon(Icons.play_arrow_rounded,
                                                color: ColorUtils.white,
                                                size: 45.w),
                                            iconSize: 64.0,
                                            onPressed: () {
                                              _player.play();
                                              _controller?.repeat();
                                              setState(() => _isPlaying = true);
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
                                                  _player.pause();
                                                  _controller?.reset();
                                                  setState(() =>
                                                      _isPlaying = !_isPlaying);
                                                },
                                              )
                                            : IconButton(
                                                icon: const Icon(Icons.replay),
                                                iconSize: 64.0,
                                                onPressed: () => _player.seek(
                                                    Duration.zero,
                                                    index: _player
                                                        .effectiveIndices!
                                                        .first),
                                              ),
                              );
                            },
                          )),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Icon(Icons.forward_10_rounded,
                          size: 56, color: ColorUtils.greyLight),
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
                        _player.seek(newPosition);
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
              color: Colors.black54.withOpacity(1 - _controller!.value),
              shape: BoxShape.circle),
        );
      },
    );
  }
}
