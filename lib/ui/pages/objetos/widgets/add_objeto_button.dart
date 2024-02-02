// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class AddObjetoButton extends StatelessWidget {
  const AddObjetoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.only(top: 7),
      child: ListTile(
        onTap: () {},
        title: Row(
          children: [
            Icon(
              Icons.add,
              color: colorScheme.onSecondaryContainer,
            ),
            SizedBox(width: 5),
            Text(
              'Añadir',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: colorScheme.onSecondaryContainer,
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        tileColor: Theme.of(context).colorScheme.secondaryContainer,
        visualDensity: VisualDensity(
          vertical: VisualDensity.minimumDensity,
        ),
      ),
    );
  }
}
