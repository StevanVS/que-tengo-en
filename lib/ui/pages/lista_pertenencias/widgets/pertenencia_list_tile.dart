import 'package:flutter/material.dart';
import 'package:que_tengo_en/domain/entities/pertenencia.dart';
import 'package:que_tengo_en/ui/pages/modal_pertenencia/modal_pertenencia.dart';

class PertenenciaListTile extends StatelessWidget {
  const PertenenciaListTile({super.key, required this.pertenencia});

  final Pertenencia pertenencia;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        ModalPertenencia.mostrarPertenenciaModal(context, pertenencia);
      },
      onLongPress: () {},
      title: Text(pertenencia.nombre),
      contentPadding: const EdgeInsets.all(0),
      visualDensity: const VisualDensity(
        vertical: VisualDensity.minimumDensity,
        horizontal: VisualDensity.minimumDensity,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      trailing: _NumeroButton(
        numero: pertenencia.cantidadEnLugar,
        onPressed: () {},
        onLongPress: () {},
      ),
      leading: _NumeroButton(
        numero: pertenencia.cantidadParaLlevar,
        onPressed: () {},
        onLongPress: () {},
      ),
    );
  }
}

class _NumeroButton extends StatelessWidget {
  const _NumeroButton({
    required this.numero,
    required this.onPressed,
    required this.onLongPress,
  });

  final int numero;
  final VoidCallback onPressed;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: onPressed,
        onLongPress: onLongPress,
        child: Text(
          '$numero',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
