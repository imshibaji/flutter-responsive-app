import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorial_app/classes/classes.dart';

final audioProvider = ChangeNotifierProvider((ref) => AudioNotifier());

class AudioNotifier extends ChangeNotifier {
  String song = 'audios/song2.mp3';
  String audio = 'audios/song2.mp3';
  AudioPlayer player = AudioPlayer();
  bool isPlay = true, isMute = false;
  double curTime = 0.0, totalTime = 0.0, volume = 0.50;

  void playerInit() {
    player.setPlayerMode(PlayerMode.mediaPlayer);
    player.setVolume(volume);
    player.release();
    onCheck();
    notifyListeners();
  }

  void setAssetUrl(String url) async {
    audio = url;
    await player.setSourceAsset(url);
    totalDuration();
    notifyListeners();
  }

  void setSourceUrl(String url) async {
    audio = url;
    await player.setSourceUrl(url);
    totalDuration();
    notifyListeners();
  }

  void setDeviceUrl(String url) async {
    audio = url;
    await player.setSource(DeviceFileSource(url));
    totalDuration();
    notifyListeners();
  }

  void onPlay() async {
    if (isPlay == true) {
      await player.resume();
    } else {
      await player.pause();
    }
    isPlay = !isPlay;
    notifyListeners();
  }

  void onStop() {
    player.stop();
    player.audioCache.clearAll();
    isPlay = true;
    notifyListeners();
  }

  void totalDuration() {
    player.onDurationChanged.listen((Duration d) {
      totalTime = d.inMilliseconds.toDouble();
      // print('Totle Duration: $totalTime');
      notifyListeners();
    });
  }

  void onCheck() {
    player.onPositionChanged.listen((Duration p) {
      var curPos = (p.inMilliseconds.toDouble() / totalTime);
      curTime = curPos < 1 ? curPos : 1.0;
      notifyListeners();
    });
    player.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.completed) {
        player.seek(Duration.zero);
        curTime = 0.0;
        isPlay = true;
        player.release();
        totalDuration();
        notifyListeners();
      }
    });
    player.onPlayerComplete.listen((_) {
      player.seek(Duration.zero);
      curTime = 0.0;
      isPlay = true;
      player.release();
      totalDuration();
      notifyListeners();
    });
  }

  void onSeek(double value) {
    player.seek(Duration(milliseconds: (value * totalTime).toInt()));
    curTime = value;
    notifyListeners();
  }

  void changeVolume(double value) {
    volume = value;
    player.setVolume(volume);
    notifyListeners();
  }

  void onMute() {
    if (isMute == false) {
      player.setVolume(0);
    } else {
      player.setVolume(1);
    }
    isMute = !isMute;
    notifyListeners();
  }

  void onDispose() {
    player.stop();
    player.release();
    player.dispose();
    isPlay = true;
    notifyListeners();
  }

  Future<String> getSong() async {
    return song;
  }

  void setSong(String song) {
    this.song = song;
    notifyListeners();
  }

  void add(String songFileLink) {
    song = songFileLink;
    notifyListeners();
  }

  void remove() {
    song = '';
    notifyListeners();
  }
}
