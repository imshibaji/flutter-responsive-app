// ignore_for_file: must_be_immutable

import 'package:tutorial_app/classes/classes.dart';
import 'package:tutorial_app/screens/screens.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUi(
      'About Page',
      centered: true,
      body: SizedBox(
        width: double.infinity,
        child: Column(children: [
          const Text('About Screen Data', style: TextStyle(fontSize: 20)),
          ClickButton(
              label: 'Goto Contact',
              onPressed: () => goToReplace(context, const ContactScreen())),
        ]),
      ),
    );
  }
}
