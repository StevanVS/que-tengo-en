import 'package:flutter/material.dart';


class ModalFooter extends StatelessWidget {
  const ModalFooter({
    super.key, required this.onAceptar,
  });

  final VoidCallback onAceptar;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton.icon(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close_rounded),
          label: const Text('Cancelar'),
        ),
        FilledButton.tonalIcon(
          onPressed: onAceptar,
          icon: const Icon(Icons.check_rounded),
          label: const Text('Aceptar'),
        ),
      ],
    );
  }
}