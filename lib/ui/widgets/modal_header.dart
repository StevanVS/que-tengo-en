import 'package:flutter/material.dart';

class ModalHeader extends StatelessWidget {
  const ModalHeader({
    super.key,
    this.elemento,
    required this.nombre,
    required this.fnEliminar,
  });

  final Object? elemento;
  final String nombre;
  final void Function() fnEliminar;

  @override
  Widget build(BuildContext context) {
    final accion = elemento == null ? 'Crear' : 'Editar';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          tooltip: 'Cerrar',
        ),
        Text(
          '$accion $nombre',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Visibility(
          visible: elemento != null,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: IconButton(
            onPressed: fnEliminar,
            icon: const Icon(Icons.delete_rounded),
            tooltip: 'Eliminar',
          ),
        )
      ],
    );
  }
}
