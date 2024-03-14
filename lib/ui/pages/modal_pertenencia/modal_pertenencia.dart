import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:que_tengo_en/domain/entities/pertenencia.dart';
import 'package:que_tengo_en/ui/widgets/modal_footer.dart';
import 'package:que_tengo_en/ui/widgets/modal_header.dart';

class ModalPertenencia extends StatefulWidget {
  const ModalPertenencia({
    super.key,
    this.pertenencia,
  });

  final Pertenencia? pertenencia;

  @override
  State<ModalPertenencia> createState() => _ModalPertenenciaState();

  static Future<dynamic> mostrarPertenenciaModal(
      BuildContext context, Pertenencia? pertenencia) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      builder: (context) {
        return ModalPertenencia(pertenencia: pertenencia);
      },
    );
  }
}

class _ModalPertenenciaState extends State<ModalPertenencia> {
  late TextEditingController _nombreController;
  late TextEditingController _cantidadEnLugarController;
  late TextEditingController _cantidadParaLlevarController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController.fromValue(
      TextEditingValue(text: widget.pertenencia?.nombre ?? ''),
    );
    _cantidadEnLugarController = TextEditingController.fromValue(
      TextEditingValue(text: '${widget.pertenencia?.cantidadEnLugar ?? ''}'),
    );
    _cantidadParaLlevarController = TextEditingController.fromValue(
      TextEditingValue(text: '${widget.pertenencia?.cantidadParaLlevar ?? ''}'),
    );
  }

  @override
  void dispose() {
    _cantidadEnLugarController.dispose();
    _cantidadParaLlevarController.dispose();
    _nombreController.dispose();
    super.dispose(); 
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          ModalHeader(
            esParaCrear: widget.pertenencia == null,
            nombre: 'Pertenencia',
            onEliminar: () {},
          ),
          const SizedBox(height: 10.0),
          ModalForm(
            nombreController: _nombreController,
            cantidadEnLugarController: _cantidadEnLugarController,
            cantidadParaLlevarController: _cantidadParaLlevarController,
          ),
          const SizedBox(height: 16.0),
          ModalFooter(onAceptar: () {}),
        ],
      ),
    );
  }
}

class ModalForm extends StatelessWidget {
  const ModalForm({
    super.key,
    required TextEditingController nombreController,
    required TextEditingController cantidadEnLugarController,
    required TextEditingController cantidadParaLlevarController,
  })  : _nombreController = nombreController,
        _cantidadEnLugarController = cantidadEnLugarController,
        _cantidadParaLlevarController = cantidadParaLlevarController;

  final TextEditingController _nombreController;
  final TextEditingController _cantidadEnLugarController;
  final TextEditingController _cantidadParaLlevarController;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextField(
            controller: _nombreController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: "Nombre",
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _cantidadEnLugarController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: const InputDecoration(
                    hintText: "00",
                    icon: Icon(Icons.location_on_rounded),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _cantidadParaLlevarController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: const InputDecoration(
                    hintText: "00",
                    icon: Icon(Icons.luggage_rounded),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
