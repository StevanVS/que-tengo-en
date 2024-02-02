// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:que_tengo_en/domain/entities/objeto.dart';

class ObjetoTile extends StatelessWidget {
  const ObjetoTile({super.key, required this.objeto});

  final Objeto objeto;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(objeto.nombre),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
        borderRadius: BorderRadius.circular(7),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      visualDensity: VisualDensity(vertical: VisualDensity.minimumDensity),
      leading: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: Theme.of(context).colorScheme.outline),
          ),
        ),
        padding: EdgeInsets.only(right: 12, left: 15),
        child: Text(
          '${objeto.cantidadEnLugar}',
          style: TextStyle(fontSize: 17),
        ),
      ),
      trailing: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: Theme.of(context).colorScheme.outline),
          ),
        ),
        padding: EdgeInsets.only(left: 12, right: 15),
        child: Text(
          '${objeto.cantidadParaLlevar}',
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}
