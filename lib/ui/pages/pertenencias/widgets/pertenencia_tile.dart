// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:que_tengo_en/domain/entities/pertenencia.dart';
import 'package:que_tengo_en/ui/pages/pertenencias/widgets/pertenencia_modal.dart';

class PertenenciaTile extends StatelessWidget {
  const PertenenciaTile({super.key, required this.pertenencia});

  final Pertenencia pertenencia;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        PertenenciaModal.mostrarPertenenciaModal(context, pertenencia);
      },
      onLongPress: () {
        //TODO ordenar pertenencias con drag
      },
      title: Text(
        pertenencia.nombre,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
        borderRadius: BorderRadius.circular(7),
      ),
      contentPadding: EdgeInsets.all(0),
      visualDensity: VisualDensity(vertical: VisualDensity.minimumDensity),
      leading: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: Theme.of(context).colorScheme.outline),
          ),
        ),
        child: numeroButton(
          context: context,
          numero: pertenencia.cantidadEnLugar,
          onPressed: () {
            //TODO aumentar en uno
          },
          onLongPress: () {
            //TODO resetar cantidad
          },
        ),
      ),
      trailing: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: Theme.of(context).colorScheme.outline),
          ),
        ),
        child: numeroButton(
          context: context,
          numero: pertenencia.cantidadParaLlevar,
          onPressed: () {
            //TODO aumentar en uno
          },
          onLongPress: () {
            //TODO resetar cantidad
          },
        ),
      ),
    );
  }

  TextButton numeroButton({
    required BuildContext context,
    required int numero,
    required void Function() onPressed,
    required void Function() onLongPress,
  }) {
    return TextButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: TextButton.styleFrom(
        shape: BeveledRectangleBorder(),
        visualDensity: VisualDensity(
          horizontal: VisualDensity.minimumDensity,
        ),
      ),
      child: Text(
        '$numero',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
          fontSize: 17,
        ),
      ),
    );
  }
}
