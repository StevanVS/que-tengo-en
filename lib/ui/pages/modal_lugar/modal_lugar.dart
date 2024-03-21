import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:que_tengo_en/domain/blocs/blocs.dart';
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
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      builder: (context) {
        context.read<LugarBloc>().add(CreateOrEditLugar(lugar));
        return ModalLugar(lugar: lugar);
      },
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
  void dispose() {
    _nombre.dispose();
    super.dispose();
  }

  void _onEliminar() {
    final bloc = context.read<LugarBloc>();
    final lugar = bloc.state.lugar;

    if (lugar != null) {
      bloc.add(DeleteLugar(lugar.id));
      Navigator.of(context).pop();
    }
  }

  void _onAceptar() {
    final bloc = context.read<LugarBloc>();
    if (_formKey.currentState!.validate()) {
      bloc.add(SubmitLugar(_nombre.text.trim()));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final esNuevoLugar = context.select(
      (LugarBloc bloc) => bloc.state.esNuevoLugar,
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
              esParaCrear: esNuevoLugar,
              nombre: 'Lugar',
              onEliminar: _onEliminar,
            ),
            const SizedBox(height: 10.0),
            ModalForm(nombreController: _nombre, onAceptar: _onAceptar),
            const SizedBox(height: 16.0),
            ModalFooter(onAceptar: _onAceptar),
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
    required VoidCallback onAceptar,
  })  : _nombreController = nombreController,
        _onAceptar = onAceptar;

  final TextEditingController _nombreController;
  final VoidCallback _onAceptar;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _nombreController,
      autofocus: true,
      onFieldSubmitted: (_) {
        _onAceptar();
      },
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
