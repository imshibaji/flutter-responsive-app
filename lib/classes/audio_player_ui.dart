// ignore_for_file: avoid_print, must_be_immutable

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorial_app/classes/audio_provider.dart';
import 'package:tutorial_app/classes/marquee.dart';

class AudioPlayerUI extends StatefulWidget {
  const AudioPlayerUI({
    super.key,
  });

  @override
  State<AudioPlayerUI> createState() => _AudioPlayerUIState();
}

class _AudioPlayerUIState extends State<AudioPlayerUI> {
  String audio = 'audios/song2.mp3';
  bool isPlay = true, isMute = false;
  double curTime = 0.0, totalTime = 0.0, volume = 0.50;
  AudioPlayer player = AudioPlayer();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      playerInit();
      setAssetUrl(audio);
    });
  }

  void playerInit() {
    player.setPlayerMode(PlayerMode.mediaPlayer);
    player.setVolume(volume);
    player.release();
    onCheck();
  }

  setAssetUrl(String url) async {
    setState(() {
      audio = url;
    });
    await player.setSourceAsset(url);
    totalDuration();
  }

  setSourceUrl(String url) async {
    setState(() {
      audio = url;
    });
    await player.setSourceUrl(url);
    totalDuration();
  }

  setDeviceUrl(String url) async {
    setState(() {
      audio = url;
    });
    await player.setSource(DeviceFileSource(url));
    totalDuration();
  }

  loadData(WidgetRef ref) {
    if (ref.watch(audioProvider.notifier).song != audio) {
      ref.watch(audioProvider.notifier).getSong().then(
            (value) => {setAssetUrl(value)},
          );
    }
  }

  void onPlay() async {
    if (isPlay == true) {
      await player.resume();
    } else {
      await player.pause();
    }
    setState(() {
      isPlay = !isPlay;
    });
  }

  void onStop() {
    player.stop();
    player.audioCache.clearAll();
    isPlay = true;
    setState(() {});
  }

  void totalDuration() {
    player.onDurationChanged.listen((Duration d) {
      setState(() {
        totalTime = d.inMilliseconds.toDouble();
      });
      // print('Totle Duration: $totalTime');
    });
  }

  void onCheck() {
    player.onPositionChanged.listen((Duration p) {
      var curPos = (p.inMilliseconds.toDouble() / totalTime);
      curTime = curPos < 1 ? curPos : 1.0;
      setState(() {});
    });
    player.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.completed) {
        player.seek(Duration.zero);
        curTime = 0.0;
        isPlay = true;
        player.release();
        totalDuration();
        setState(() {});
      }
    });
    player.onPlayerComplete.listen((_) {
      player.seek(Duration.zero);
      curTime = 0.0;
      isPlay = true;
      player.release();
      totalDuration();
      setState(() {});
    });
  }

  void onSeek(double value) {
    player.seek(Duration(milliseconds: (value * totalTime).toInt()));
    curTime = value;
    setState(() {});
  }

  void changeVolume(double value) {
    setState(() {
      volume = value;
      player.setVolume(volume);
    });
  }

  void onMute() {
    if (isMute == false) {
      player.setVolume(0);
    } else {
      player.setVolume(1);
    }
    setState(() {
      isMute = !isMute;
    });
  }

  void onDispose() {
    player.stop();
    player.release();
    player.dispose();
  }

  @override
  void dispose() {
    super.dispose();
    onDispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Center(
                child: Row(
              children: [
                playStopButtons(context),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Marquee(
                        child: Text(
                          '#Song Name #Song Name #Song Name #Song Name #Song Name #Song Name',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      Marquee(
                        child: Text('#Channel Name',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onPrimary,
                            )),
                      ),
                    ],
                  ),
                ),
                muteVolumeButtons(context),
              ],
            )),
          ),
          Positioned(
            bottom: -22,
            left: -22,
            right: -22,
            child: Slider(
              thumbColor: Colors.transparent,
              overlayColor: const MaterialStatePropertyAll(Colors.transparent),
              secondaryActiveColor: Colors.transparent,
              activeColor: Colors.white.withOpacity(0.5),
              secondaryTrackValue: null,
              max: 1.0,
              min: 0.0,
              value: curTime,
              onChanged: onSeek,
            ),
          )
        ],
      ),
    );
  }

  Row muteVolumeButtons(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onMute,
          icon: Icon(
            isMute ? Icons.volume_off : Icons.volume_up,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 30,
          ),
        ),
        SizedBox(
          width: 100,
          child: Slider(
            activeColor: Colors.white,
            max: 1.0,
            min: 0.0,
            value: volume,
            onChanged: changeVolume,
          ),
        ),
      ],
    );
  }

  Consumer playStopButtons(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      loadData(ref);
      return Row(
        children: [
          IconButton(
            onPressed: () => onPlay(),
            icon: Icon(
              isPlay ? Icons.play_arrow_outlined : Icons.pause,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () => onStop(),
            icon: Icon(
              Icons.stop,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 30,
            ),
          ),
        ],
      );
    });
  }
}
