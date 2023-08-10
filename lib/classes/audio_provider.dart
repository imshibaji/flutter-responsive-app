import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorial_app/classes/classes.dart';

final audioProvider = ChangeNotifierProvider((ref) => AudioNotifier());

class AudioNotifier extends ChangeNotifier {
  String song = 'audios/song2.mp3';

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
