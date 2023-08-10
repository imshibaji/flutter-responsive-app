import 'package:tutorial_app/classes/classes.dart';

final lists = List.generate(
  20,
  (i) => ListData(
    'Todo $i',
    'A description of what needs to be done for Todo $i',
  ),
);
