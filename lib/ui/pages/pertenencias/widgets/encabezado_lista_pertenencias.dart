// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class EncabezadoListaPertenencias extends StatelessWidget {
  const EncabezadoListaPertenencias({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            null;
          },
          onLongPress: () {
            //TODO resetar cantidad en lugar
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.location_on_rounded,
              size: 30,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        Text(
          'Nombre',
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            null;
          },
          onLongPress: () {
            //TODO resetar cantidad para llevar
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.luggage_rounded,
              size: 30,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
