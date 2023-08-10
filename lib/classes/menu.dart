import 'package:flutter/widgets.dart';

class Menu {
  late String title;
  late Widget icon;
  late Function(BuildContext context)? onTap;
  Menu({required this.title, required this.icon, this.onTap});
}
