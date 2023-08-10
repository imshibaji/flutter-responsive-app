import 'package:tutorial_app/classes/classes.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.todo});

  // Declare a field that holds the Todo.
  final ListData todo;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(todo.description),
      ),
    );
  }
}
