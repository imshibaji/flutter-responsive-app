// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tutorial_app/classes/app_footer.dart';
import 'package:tutorial_app/classes/classes.dart';
import 'package:tutorial_app/classes/theme_mode_button.dart';
import 'package:tutorial_app/classes/theme_provider.dart';
import 'package:tutorial_app/configs/menus.dart';
import 'package:tutorial_app/configs/settings.dart';

class ScreenUi extends ConsumerStatefulWidget {
  final String title;
  Widget? body, smallBody, mediumBody, largeBody, appFooter;
  bool? centered;
  double? footerHeight;

  ScreenUi(this.title,
      {super.key,
      this.centered,
      this.body,
      this.smallBody,
      this.mediumBody,
      this.largeBody,
      this.appFooter,
      this.footerHeight = 50.0});

  @override
  ConsumerState<ScreenUi> createState() => _ScreenUiState();
}

class _ScreenUiState extends ConsumerState<ScreenUi> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    ref.read(themeProvider);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mode = ref.watch(themeProvider.notifier).mode;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        leading: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                mode == ThemeMode.light ? appIcon : appIconDark,
                fit: BoxFit.contain,
              ),
            ),
            onTap: () {
              menus[0].onTap!(context);
            }),
        centerTitle: size.width < 600 ? widget.centered : false,
        title: Text(
          widget.title,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        actions: getActions(size, context, ref),
      ),
      body: size.width < smallDeviceWide
          ? widget.smallBody ?? widget.body
          : size.width < mediumDeviceWide
              ? widget.mediumBody ?? widget.body
              : widget.largeBody ?? widget.body,
      extendBody: true,
      bottomNavigationBar: AppFooter(
        player: widget.appFooter,
        height: widget.footerHeight!,
      ),
    );
  }

  List<Widget> getActions(Size size, BuildContext context, WidgetRef ref) {
    return [
      size.width < 750
          ? SizedBox(
              width: 96,
              child: Row(
                children: [
                  const ThemeModeButton(),
                  PopupMenuButton(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.5),
                    icon: Icon(
                      Icons.menu_open,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onSelected: (value) {
                      if (kDebugMode) {
                        print(value);
                      }
                    },
                    itemBuilder: (context) => [
                      for (var menu in menus)
                        PopupMenuItem(
                          padding: const EdgeInsets.all(0),
                          value: menu.title,
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () => menu.onTap!(context),
                              icon: menu.icon,
                              label: Text(menu.title),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.6),
                                  foregroundColor:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fixedSize: const Size(200, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  )),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ))
          : Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ThemeModeButton(),
                  for (var menu in menus)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: ElevatedButton.icon(
                        icon: menu.icon,
                        onPressed: () => menu.onTap!(context),
                        label: Text(menu.title),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5),
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
    ];
  }
}
