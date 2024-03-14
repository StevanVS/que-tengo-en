import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:que_tengo_en/domain/bloc/bloc.dart';
import 'package:que_tengo_en/domain/entities/lugar.dart';
import 'package:que_tengo_en/ui/pages/lista_pertenencias/widgets/pertenencia_list_tile.dart';

import 'widgets/encabezado_lista_pertenencias.dart';
import '../modal_pertenencia/modal_pertenencia.dart';

class ListaPertenenciasPage extends StatefulWidget {
  const ListaPertenenciasPage({super.key, required this.lugar});

  final Lugar lugar;

  @override
  State<ListaPertenenciasPage> createState() => _ListaPertenenciasPageState();
}

class _ListaPertenenciasPageState extends State<ListaPertenenciasPage> {
  @override
  void initState() {
    super.initState();
    context.read<PertenenciaBloc>().add(GetPertenencias(lugar: widget.lugar));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.lugar.nombre),
      ),
      body: BlocBuilder<PertenenciaBloc, PertenenciaState>(
        builder: (context, state) {
          if (state.pertenenciaStatus == PertenenciaStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.listaPertenencias.isEmpty) {
            return Center(
              child: Text(
                'No existen Pertenencias',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const EncabezadoListaPertenencias(),
                  const SizedBox(height: 8),
                  ListView.builder(
                    itemCount: state.listaPertenencias.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return PertenenciaListTile(
                        pertenencia: state.listaPertenencias[index],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ModalPertenencia.mostrarPertenenciaModal(context, null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
