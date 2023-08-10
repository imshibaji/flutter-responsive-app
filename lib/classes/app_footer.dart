// ignore_for_file: must_be_immutable

import 'dart:ui';
import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  double height;
  Widget? player;
  AppFooter({
    super.key,
    this.height = 0.0,
    this.player,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height + 16,
      child: Column(
        children: [
          player != null
              ? Padding(
                  padding: const EdgeInsets.only(
                      bottom: 6, left: 8, right: 8, top: 10),
                  child: player,
                )
              : Container(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: ShapeDecoration(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0),
                  Theme.of(context).colorScheme.primary,
                ],
              ),
            ),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: BottomNavigationBar(
                    elevation: 0, // to get rid of the shadow
                    currentIndex: 0,
                    selectedItemColor: Theme.of(context).colorScheme.onPrimary,
                    onTap: (int val) {},
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.8),
                    type: BottomNavigationBarType.fixed,
                    unselectedItemColor:
                        Theme.of(context).colorScheme.onPrimary,
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.search),
                        label: 'Level',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.layers_outlined),
                        label: 'Your Library',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.notifications),
                        label: 'Notification',
                      ),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
