import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:que_tengo_en/domain/blocs/blocs.dart';
import 'package:que_tengo_en/domain/entities/pertenencia.dart';
import 'package:que_tengo_en/ui/pages/modal_pertenencia/modal_pertenencia.dart';

import 'numero_button.dart';

class PertenenciaListTile extends StatelessWidget {
  const PertenenciaListTile({super.key, required this.pertenencia});

  final Pertenencia pertenencia;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PertenenciaBloc>();
    return ListTile(
      onTap: () {
        ModalPertenencia.mostrarPertenenciaModal(context, pertenencia);
      },
      title: Text(pertenencia.nombre),
      contentPadding: const EdgeInsets.all(0),
      visualDensity: const VisualDensity(
        vertical: VisualDensity.minimumDensity,
        horizontal: VisualDensity.minimumDensity,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      leading: NumeroButton(
        numero: pertenencia.cantidadEnLugar,
        onPressed: () {
          bloc.add(
            IncrementCantidad(
              pertenencia: pertenencia,
              tipoCantidad: TipoCantidad.enLugar,
            ),
          );
        },
        onLongPress: () {
          bloc.add(
            ResetCantidad(
              pertenencia: pertenencia,
              tipoCantidad: TipoCantidad.enLugar,
            ),
          );
        },
      ),
      trailing: NumeroButton(
        numero: pertenencia.cantidadParaLlevar,
        onPressed: () {
          bloc.add(
            IncrementCantidad(
              pertenencia: pertenencia,
              tipoCantidad: TipoCantidad.paraLlevar,
            ),
          );
        },
        onLongPress: () {
          bloc.add(
            ResetCantidad(
              pertenencia: pertenencia,
              tipoCantidad: TipoCantidad.paraLlevar,
            ),
          );
        },
      ),
    );
  }
}
