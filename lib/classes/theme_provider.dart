import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorial_app/classes/classes.dart';

final themeProvider = ChangeNotifierProvider((ref) => ThemeNotifier());

class ThemeNotifier extends ChangeNotifier {
  ThemeMode mode = ThemeMode.light;

  void light() {
    mode = ThemeMode.light;
    notifyListeners();
  }

  void dark() {
    mode = ThemeMode.dark;
    notifyListeners();
  }

  void toggle() {
    mode = mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
