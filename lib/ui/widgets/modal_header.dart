import 'package:flutter/material.dart';

class ModalHeader extends StatelessWidget {
  const ModalHeader({
    super.key,
    required this.esParaCrear,
    required this.nombre,
    required this.onEliminar,
  });

  final bool esParaCrear;
  final String nombre;
  final VoidCallback onEliminar;

  @override
  Widget build(BuildContext context) {
    final accion = esParaCrear ? 'Crear' : 'Editar';

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
          visible: !esParaCrear,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: IconButton(
            onPressed: onEliminar,
            icon: const Icon(Icons.delete_rounded),
            tooltip: 'Eliminar',
          ),
        )
      ],
    );
  }
}
