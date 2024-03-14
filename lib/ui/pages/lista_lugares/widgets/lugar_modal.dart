// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:que_tengo_en/domain/entities/lugar.dart';
import 'package:que_tengo_en/ui/widgets/modal_footer.dart';
import 'package:que_tengo_en/ui/widgets/modal_header.dart';

class LugarModal extends StatefulWidget {
  const LugarModal({super.key, this.lugar});

  final Lugar? lugar;

  @override
  State<LugarModal> createState() => _LugarModalState();

  static Future<dynamic> mostrarLugarModal(BuildContext context, Lugar? lugar) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return LugarModal(lugar: lugar);
      },
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
    );
  }
}

class _LugarModalState extends State<LugarModal> {
  final double _padding = 15;
  late TextEditingController _nombreController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController.fromValue(
      TextEditingValue(text: widget.lugar?.nombre ?? ''),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: _padding,
        right: _padding,
        left: _padding,
        bottom: MediaQuery.of(context).viewInsets.bottom + _padding,
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ModalHeader(
            esParaCrear: widget.lugar != null,
            nombre: 'Lugar',
            onEliminar: () {
              //TODO eliminar lugar
            },
          ),
          const SizedBox(height: 10.0),
          ModalForm(nombreController: _nombreController),
          const SizedBox(height: 16.0),
          ModalFooter(onAceptar: () {
            //TODO aceptar lugar
          }),
        ],
      ),
    );
  }
}

class ModalForm extends StatelessWidget {
  const ModalForm({
    super.key,
    required TextEditingController nombreController,
  }) : _nombreController = nombreController;

  final TextEditingController _nombreController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _nombreController,
      // autofocus: true,
      decoration: InputDecoration(
        hintText: "Nombre",
      ),
    );
  }
}
