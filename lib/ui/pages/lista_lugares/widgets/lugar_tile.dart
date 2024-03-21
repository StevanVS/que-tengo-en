import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:que_tengo_en/domain/blocs/blocs.dart';
import 'package:que_tengo_en/domain/entities/lugar.dart';
import 'package:que_tengo_en/ui/pages/lista_pertenencias/lista_pertenencias_page.dart';
import 'package:que_tengo_en/ui/pages/modal_lugar/modal_lugar.dart';

class LugarTile extends StatelessWidget {
  const LugarTile({super.key, required this.lugar});

  final Lugar lugar;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          ListaPertenenciasPage.route(lugar),
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    context.read<LugarBloc>().add(ToggleFavorito(lugar));
                  },
                  icon: Icon(
                    lugar.favorito
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      lugar.nombre,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ModalLugar.mostrarLugarModal(context, lugar);
                  },
                  icon: const Icon(Icons.more_vert_rounded),
                ),
              ],
            ),
          ),
          const Divider(height: 0.5, thickness: 0.5)
        ],
      ),
    );
  }
}
