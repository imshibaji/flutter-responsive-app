import 'package:tutorial_app/classes/classes.dart';
import 'package:tutorial_app/configs/data_lists.dart';
import 'package:tutorial_app/screens/screens.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUi(
      'Contact Page',
      body: SizedBox(
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClickButton(
                label: 'Goto Home',
                onPressed: () => goToReplace(context, const HomeScreen())),
            const Divider(),
            Expanded(
              child: listViewBuilder(
                context,
                lists,
                callback: (todo) => DetailScreen(todo: todo),
              ),
            )
          ],
        ),
      ),
    );
  }
}
