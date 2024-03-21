import 'package:flutter/material.dart';
import 'package:que_tengo_en/domain/entities/lugar.dart';
import 'package:que_tengo_en/ui/pages/lista_lugares/widgets/lugar_modal.dart';
import 'package:que_tengo_en/ui/pages/lista_pertenencias/lista_pertenencias_page.dart';

class LugarListTile extends StatelessWidget {
  const LugarListTile({super.key, required this.lugar});

  final Lugar lugar;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            lugar.nombre,
            style: const TextStyle(fontSize: 18),
          ),
          // shape: RoundedRectangleBorder(
          //   side: BorderSide(color: Theme.of(context).colorScheme.outline),
          //   borderRadius: BorderRadius.circular(5),
          // ),
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              lugar.favorito ? Icons.star_rounded : Icons.star_outline_rounded,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              LugarModal.mostrarLugarModal(context, lugar);
            },
            icon: const Icon(Icons.edit_rounded),
          ),
          onTap: () {
            Navigator.push(
              context,
              ListaPertenenciasPage.route(lugar),
            );
          },
          contentPadding: const EdgeInsets.all(0),
        ),
        const Divider(height: 0.5, thickness: 0.5)
      ],
    );
  }
}
