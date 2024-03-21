import 'package:flutter/material.dart';

class CenterTextForEmptyList extends StatelessWidget {
  const CenterTextForEmptyList(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
