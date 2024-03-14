import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberTextField extends StatelessWidget {
  const NumberTextField({
    super.key,
    required this.controller,
    required this.icon,
  });

  final TextEditingController controller;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    controller.text = controller.text.isNotEmpty ? controller.text : '0';

    return TextFormField(
      textAlign: TextAlign.center,
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      decoration: InputDecoration(
        hintText: "00",
        icon: Icon(icon),
      ),
      validator: (value) {
        if ((value ?? '').trim().isEmpty) return "Este campo es requerido";
        return null;
      },
    );
  }
}
