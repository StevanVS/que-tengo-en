import 'package:flutter/material.dart';


class ModalFooter extends StatelessWidget {
  const ModalFooter({
    super.key, required this.fnAceptar,
  });

  final void Function() fnAceptar;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FilledButton.tonalIcon(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close_rounded),
          label: const Text('Cancelar'),
        ),
        FilledButton.tonalIcon(
          onPressed: fnAceptar,
          icon: const Icon(Icons.check_rounded),
          label: const Text('Aceptar'),
        ),
      ],
    );
  }
}