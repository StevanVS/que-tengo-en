// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class EncabezadoObjetos extends StatelessWidget {
  const EncabezadoObjetos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.location_on_rounded),
          visualDensity: VisualDensity(
            horizontal: VisualDensity.minimumDensity,
          ),
          // iconSize: 28,
        ),
        Text(
          'Nombre',
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.secondary
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.luggage_rounded),
          visualDensity: VisualDensity(
            horizontal: VisualDensity.minimumDensity,
          ),
        ),
      ],
    );
  }
}
