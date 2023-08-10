// ignore_for_file: avoid_print, must_be_immutable
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorial_app/classes/audio_provider.dart';
import 'package:tutorial_app/classes/marquee.dart';

class AudioPlayerUI2 extends ConsumerStatefulWidget {
  const AudioPlayerUI2({
    super.key,
  });

  @override
  ConsumerState<AudioPlayerUI2> createState() => _AudioPlayerUIState();
}

class _AudioPlayerUIState extends ConsumerState<AudioPlayerUI2> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted &&
          ref.read(audioProvider).player.state != PlayerState.playing) {
        ref.read(audioProvider).playerInit();
        ref.read(audioProvider).setAssetUrl(ref.read(audioProvider).audio);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted &&
          ref.read(audioProvider).player.state == PlayerState.playing) {
        ref.read(audioProvider).setAssetUrl(ref.read(audioProvider).audio);
        ref.read(audioProvider).onSeek(ref.read(audioProvider).curTime);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    // ref.read(audioProvider).onDispose();
  }

  void loadData() {
    if (ref.watch(audioProvider.notifier).song !=
        ref.watch(audioProvider.notifier).audio) {
      ref.watch(audioProvider.notifier).getSong().then(
            (value) => {ref.read(audioProvider).setAssetUrl(value)},
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    loadData();
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
              value: ref.watch(audioProvider).curTime,
              onChanged: ref.read(audioProvider).onSeek,
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
          onPressed: ref.read(audioProvider).onMute,
          icon: Icon(
            ref.watch(audioProvider).isMute
                ? Icons.volume_off
                : Icons.volume_up,
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
            value: ref.watch(audioProvider).volume,
            onChanged: ref.read(audioProvider).changeVolume,
          ),
        ),
      ],
    );
  }

  Row playStopButtons(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => ref.read(audioProvider).onPlay(),
          icon: Icon(
            ref.watch(audioProvider).isPlay
                ? Icons.play_arrow_outlined
                : Icons.pause,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 30,
          ),
        ),
        IconButton(
          onPressed: () => ref.read(audioProvider).onStop(),
          icon: Icon(
            Icons.stop,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 30,
          ),
        ),
      ],
    );
  }
}
