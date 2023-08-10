import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorial_app/classes/classes.dart';
import 'package:tutorial_app/classes/theme_provider.dart';

class ThemeModeButton extends ConsumerStatefulWidget {
  const ThemeModeButton({
    super.key,
  });

  @override
  ConsumerState<ThemeModeButton> createState() => _ThemeModeButtonState();
}

class _ThemeModeButtonState extends ConsumerState<ThemeModeButton> {
  @override
  Widget build(BuildContext context) {
    final ts = ref.watch(themeProvider.notifier).mode;
    return IconButton(
      tooltip: 'Toggle Theme',
      icon: Icon(
        ts == ThemeMode.light ? Icons.nightlight_round : Icons.sunny,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      onPressed: () {
        ref.read(themeProvider).toggle();
      },
    );
  }
}
