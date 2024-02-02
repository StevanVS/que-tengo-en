import 'package:flutter/material.dart';
import 'package:que_tengo_en/domain/entities/lugar.dart';
import 'package:que_tengo_en/ui/pages/objetos/objetos_page.dart';

class LugarTile extends StatelessWidget {
  const LugarTile({super.key, required this.lugar});

  final Lugar lugar;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        lugar.nombre,
        style: const TextStyle(fontSize: 18),
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
        borderRadius: BorderRadius.circular(10),
      ),
      trailing: Icon(
        lugar.favorito ? Icons.star_rounded : Icons.star_outline_rounded,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ObjetosPage(lugar: lugar)),
        );
      },
    );
  }
}
