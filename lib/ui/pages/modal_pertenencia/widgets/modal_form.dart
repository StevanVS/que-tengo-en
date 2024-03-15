import 'package:flutter/material.dart';
import 'package:que_tengo_en/ui/pages/modal_pertenencia/widgets/number_text_field.dart';

class ModalForm extends StatelessWidget {
  const ModalForm({
    super.key,
    required TextEditingController nombreController,
    required TextEditingController cantidadEnLugarController,
    required TextEditingController cantidadParaLlevarController,
  })  : _nombre = nombreController,
        _cantidadEnLugar = cantidadEnLugarController,
        _cantidadParaLlevar = cantidadParaLlevarController;

  final TextEditingController _nombre;
  final TextEditingController _cantidadEnLugar;
  final TextEditingController _cantidadParaLlevar;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _nombre,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Nombre",
          ),
          textCapitalization: TextCapitalization.sentences,
          validator: (value) {
            if ((value ?? '').trim().isEmpty) return "Este campo es requerido";
            return null;
          },
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: NumberTextField(
                controller: _cantidadEnLugar,
                icon: Icons.location_on_rounded,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: NumberTextField(
                controller: _cantidadParaLlevar,
                icon: Icons.luggage_rounded,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
