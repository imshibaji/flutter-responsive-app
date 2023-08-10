import 'package:tutorial_app/classes/classes.dart';
import 'package:tutorial_app/screens/screens.dart';

List<Menu> menus = [
  Menu(
    title: 'Home',
    icon: const Icon(
      Icons.home,
    ),
    onTap: (context) {
      goToReplace(context, const HomeScreen());
    },
  ),
  Menu(
    title: 'About',
    icon: const Icon(
      Icons.info,
    ),
    onTap: (context) {
      goToReplace(context, const AboutScreen());
    },
  ),
  Menu(
    title: 'Details',
    icon: const Icon(
      Icons.info,
    ),
    onTap: (context) {
      goToReplace(context, const AboutScreen());
    },
  ),
  Menu(
    title: 'Contact',
    icon: const Icon(
      Icons.email,
    ),
    onTap: (context) {
      goToReplace(context, const ContactScreen());
    },
  )
];
