import 'package:flutter/material.dart';
import 'package:tutorial_app/classes/goto.dart';

class ListData {
  final String title;
  final String description;

  const ListData(this.title, this.description);
}

Widget listViewBuilder(BuildContext context, List<ListData> todos,
    {required Function(ListData) callback}) {
  return ListView.builder(
    itemCount: todos.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(todos[index].title),
        subtitle: Text(todos[index].description),
        onTap: () {
          goTo(context, callback(todos[index]));
        },
      );
    },
  );
}
