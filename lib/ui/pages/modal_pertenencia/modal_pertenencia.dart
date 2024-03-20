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
              esParaCrear: widget.pertenencia == null,
              nombre: 'Pertenencia',
              onEliminar: () {
                if (widget.pertenencia?.id == null) return;

                context
                    .read<PertenenciaBloc>()
                    .add(DeletePertenencia(widget.pertenencia!.id!));

                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: 10.0),
            ModalForm(
              nombreController: nombre,
              cantidadEnLugarController: enLugar,
              cantidadParaLlevarController: paraLlevar,
            ),
            const SizedBox(height: 16.0),
            ModalFooter(
              onAceptar: () {
                final bloc = context.read<PertenenciaBloc>();
                final lugar = bloc.state.lugar;

                if (_formKey.currentState!.validate()) {
                  final pertenencia = widget.pertenencia != null
                      ? widget.pertenencia!.copyWith(
                          nombre: nombre.text.trim(),
                          cantidadEnLugar: int.parse(enLugar.text),
                          cantidadParaLlevar: int.parse(paraLlevar.text))
                      : Pertenencia(
                          lugarId: lugar!.id,
                          nombre: nombre.text.trim(),
                          cantidadEnLugar: int.parse(enLugar.text),
                          cantidadParaLlevar: int.parse(paraLlevar.text));

                  bloc.add(SubmitPertenencia(pertenencia));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
