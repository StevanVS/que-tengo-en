import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:que_tengo_en/domain/blocs/blocs.dart';
import 'package:que_tengo_en/domain/entities/pertenencia.dart';
import 'package:que_tengo_en/ui/widgets/modal_footer.dart';
import 'package:que_tengo_en/ui/widgets/modal_header.dart';

import 'widgets/modal_form.dart';

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
        context
            .read<PertenenciaBloc>()
            .add(CreateOrEditPertenencia(pertenencia));
        return ModalPertenencia(pertenencia: pertenencia);
      },
    );
  }
}

class _ModalPertenenciaState extends State<ModalPertenencia> {
  final _formKey = GlobalKey<FormState>();
  final nombre = TextEditingController();
  final enLugar = TextEditingController();
  final paraLlevar = TextEditingController();

  @override
  void initState() {
    super.initState();
    nombre.text = widget.pertenencia?.nombre ?? '';
    enLugar.text = '${widget.pertenencia?.cantidadEnLugar ?? ''}';
    paraLlevar.text = '${widget.pertenencia?.cantidadParaLlevar ?? ''}';
  }

  @override
  void dispose() {
    nombre.dispose();
    enLugar.dispose();
    paraLlevar.dispose();
    super.dispose();
  }

  _onEliminar() {
    final bloc = context.read<PertenenciaBloc>();
    final pertenencia = bloc.state.pertenencia;

    if (pertenencia != null) {
      bloc.add(DeletePertenencia(pertenencia.id));
      Navigator.of(context).pop();
    }
  }

  _onAceptar() {
    final bloc = context.read<PertenenciaBloc>();

    if (_formKey.currentState!.validate()) {
      bloc.add(SubmitPertenencia(
        nombre: nombre.text.trim(),
        cantidadEnLugar: int.parse(enLugar.text),
        cantidadParaLlevar: int.parse(paraLlevar.text),
      ));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final esParaCrear = context.select(
      (PertenenciaBloc bloc) => bloc.state.esNuevaPertenencia,
    );

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
              esParaCrear: esParaCrear,
              nombre: 'Pertenencia',
              onEliminar: _onEliminar,
            ),
            const SizedBox(height: 10.0),
            ModalForm(
              nombreController: nombre,
              cantidadEnLugarController: enLugar,
              cantidadParaLlevarController: paraLlevar,
              onAceptar: _onAceptar,
            ),
            const SizedBox(height: 16.0),
            ModalFooter(onAceptar: _onAceptar),
          ],
        ),
      ),
    );
  }
}
