import 'package:flutter/material.dart';
import 'package:que_tengo_en/domain/entities/lugar.dart';
import 'package:que_tengo_en/ui/widgets/modal_footer.dart';
import 'package:que_tengo_en/ui/widgets/modal_header.dart';

class ModalLugar extends StatefulWidget {
  const ModalLugar({super.key, this.lugar});

  final Lugar? lugar;

  @override
  State<ModalLugar> createState() => _ModalLugarState();

  static Future<dynamic> mostrarLugarModal(BuildContext context, Lugar? lugar) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return ModalLugar(lugar: lugar);
      },
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
    );
  }
}

class _ModalLugarState extends State<ModalLugar> {
  final _formKey = GlobalKey<FormState>();
  final _nombre = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nombre.text = widget.lugar?.nombre ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15).copyWith(
        bottom: MediaQuery.of(context).viewInsets.bottom + 15,
      ),
      width: MediaQuery.of(context).size.width,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ModalHeader(
              esParaCrear: widget.lugar == null,
              nombre: 'Lugar',
              onEliminar: () {},
            ),
            const SizedBox(height: 10.0),
            ModalForm(nombreController: _nombre),
            const SizedBox(height: 16.0),
            ModalFooter(onAceptar: () {}),
          ],
        ),
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
    return TextFormField(
      controller: _nombreController,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: "Nombre",
      ),
      textCapitalization: TextCapitalization.sentences,
          validator: (value) {
            if ((value ?? '').trim().isEmpty) return "Este campo es requerido";
            return null;
          },
    );
  }
}
