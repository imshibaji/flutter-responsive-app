import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorial_app/classes/theme_provider.dart';
import 'package:tutorial_app/screens/home_screen.dart';

void main() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor:
                Colors.primaries[Random().nextInt(Colors.primaries.length)]),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(primary: Colors.grey),
      ),
      // ignore: invalid_use_of_protected_member
      themeMode: ref.watch(themeProvider).mode,
      home: const HomeScreen(),
    );
  }
}
