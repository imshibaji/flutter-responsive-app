// ignore_for_file: must_be_immutable

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorial_app/classes/audio_player_ui.dart';
import 'package:tutorial_app/classes/audio_provider.dart';
import 'package:tutorial_app/classes/classes.dart';
import 'package:tutorial_app/classes/show_message.dart';
import 'package:tutorial_app/screens/screens.dart';
import 'package:carousel_slider/carousel_slider.dart';

final images = [
  'assets/images/1.jpg',
  'assets/images/2.jpg',
  'assets/images/3.jpg',
  'assets/images/4.jpg',
  'assets/images/5.jpg',
];

final audios = [
  'audios/song1.wav',
  'audios/song2.mp3',
];

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUi(
      'Home Page',
      centered: true,
      smallBody: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              sliders(context),
              Column(children: [
                const Text('Small Home Screen Data',
                    style: TextStyle(fontSize: 20)),
                ClickButton(
                  label: 'Goto About',
                  onPressed: () => goToReplace(
                    context,
                    const AboutScreen(),
                  ),
                ),
                songsButtons(context, ref),
              ]),
            ],
          ),
        ),
      ),
      mediumBody: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                sliders(context),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Medium Home Screen Data',
                          style: TextStyle(fontSize: 20)),
                      ClickButton(
                          label: 'Goto About',
                          onPressed: () =>
                              goToReplace(context, const AboutScreen())),
                    ]),
                songsButtons(context, ref),
              ],
            ),
          ),
        ),
      ),
      largeBody: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                sliders(context),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClickButton(
                          label: 'Goto About',
                          onPressed: () =>
                              goToReplace(context, const AboutScreen())),
                      const Text('Large Home Screen Data',
                          style: TextStyle(fontSize: 20)),
                      ClickButton(
                        label: 'Goto About',
                        onPressed: () =>
                            goToReplace(context, const AboutScreen()),
                      ),
                    ]),
                songsButtons(context, ref),
              ],
            ),
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(children: [
          const Text('Home Screen Data', style: TextStyle(fontSize: 20)),
          ClickButton(
              label: 'Goto About',
              onPressed: () => goToReplace(context, const AboutScreen())),
        ]),
      ),
      appFooter: const AudioPlayerUI(),
      footerHeight: 134,
    );
  }

  SizedBox songsButtons(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...audios
              .map(
                (audio) => ClickIconButton(
                  icon: Icons.queue_music,
                  label: 'Song ${audios.indexOf(audio) + 1}',
                  onPressed: () {
                    ref.read(audioProvider.notifier).setSong(audio);
                    showMessage(
                      context,
                      'Song ${audios.indexOf(audio) + 1} Added',
                    );
                  },
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  SizedBox sliders(BuildContext context) {
    final imgHeight = ((MediaQuery.of(context).size.width * 0.5) < 600)
        ? (MediaQuery.of(context).size.width * 0.5)
        : 600.0;
    return SizedBox(
      width: double.infinity,
      height: imgHeight,
      child: CarouselSlider(
        options: CarouselOptions(
          height: imgHeight,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          scrollDirection: Axis.horizontal,
        ),
        items: images.map((image) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: const BoxDecoration(color: Colors.amber),
                child: Image.asset(image, fit: BoxFit.fill),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
