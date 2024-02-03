import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:que_tengo_en/domain/entities/pertenencia.dart';
import 'package:que_tengo_en/ui/widgets/modal_footer.dart';
import 'package:que_tengo_en/ui/widgets/modal_header.dart';

class PertenenciaModal extends StatefulWidget {
  const PertenenciaModal({
    super.key,
    this.pertenencia,
  });

  final Pertenencia? pertenencia;

  @override
  State<PertenenciaModal> createState() => _PertenenciaModalState();

  static Future<dynamic> mostrarPertenenciaModal(
      BuildContext context, Pertenencia? pertenencia) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return PertenenciaModal(pertenencia: pertenencia);
      },
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
    );
  }
}

class _PertenenciaModalState extends State<PertenenciaModal> {
  final double _padding = 15;

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
            elemento: widget.pertenencia,
            nombre: 'Pertenencia',
            fnEliminar: () {
              //TODO eliminar pertenencia
            },
          ),
          const SizedBox(height: 10.0),
          ModalForm(
            nombreController: _nombreController,
            cantidadEnLugarController: _cantidadEnLugarController,
            cantidadParaLlevarController: _cantidadParaLlevarController,
          ),
          const SizedBox(height: 16.0),
          ModalFooter(fnAceptar: () {
            //TODO aceptar pertenencia
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
    return Column(
      children: [
        TextField(
          controller: _nombreController,
          // autofocus: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            hintText: "Nombre",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
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
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  hintText: "0",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  icon: const Icon(Icons.location_on_rounded),
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
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  hintText: "0",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  icon: const Icon(Icons.luggage_rounded),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
