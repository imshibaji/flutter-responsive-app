// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ClickButton extends StatelessWidget {
  String label;
  Function() onPressed;
  ClickButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withAlpha(50),
              Theme.of(context).colorScheme.primary,
            ],
          ),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.5),
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            padding: const EdgeInsets.all(16.0),
          ),
          child: Text(
            label,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}

class ClickIconButton extends StatelessWidget {
  String label;
  Function() onPressed;
  IconData? icon;
  ClickIconButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon = Icons.add,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withAlpha(50),
              Theme.of(context).colorScheme.primary,
            ],
          ),
        ),
        child: ElevatedButton.icon(
          icon: Icon(icon, color: Theme.of(context).colorScheme.onPrimary),
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.5),
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            padding: const EdgeInsets.all(16),
          ),
          label: Text(
            label,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}
