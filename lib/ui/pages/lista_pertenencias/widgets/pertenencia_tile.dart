import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:que_tengo_en/domain/blocs/blocs.dart';
import 'package:que_tengo_en/domain/entities/pertenencia.dart';
import 'package:que_tengo_en/ui/pages/modal_pertenencia/modal_pertenencia.dart';

import 'numero_button.dart';

class PertenenciaTile extends StatelessWidget {
  const PertenenciaTile({super.key, required this.pertenencia});

  final Pertenencia pertenencia;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PertenenciaBloc>();
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () {
          ModalPertenencia.mostrarPertenenciaModal(context, pertenencia);
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NumeroButton(
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      pertenencia.nombre,
                      // style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                NumeroButton(
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
              ],
            ),
            const Divider(thickness: 0.5, height: 0.5)
          ],
        ),
      ),
    );
  }
}
