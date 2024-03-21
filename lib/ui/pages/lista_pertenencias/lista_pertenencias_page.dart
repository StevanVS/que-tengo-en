import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:que_tengo_en/domain/blocs/blocs.dart';
import 'package:que_tengo_en/domain/entities/lugar.dart';
import 'package:que_tengo_en/ui/pages/lista_pertenencias/widgets/pertenencia_tile.dart';
import 'package:que_tengo_en/ui/widgets/center_text_list_empty.dart';

import 'widgets/encabezado_lista_pertenencias.dart';
import '../modal_pertenencia/modal_pertenencia.dart';

class ListaPertenenciasPage extends StatefulWidget {
  const ListaPertenenciasPage({super.key, required this.lugar});

  final Lugar lugar;

  @override
  State<ListaPertenenciasPage> createState() => _ListaPertenenciasPageState();

  static MaterialPageRoute route(Lugar lugar) {
    return MaterialPageRoute(
      builder: (context) => ListaPertenenciasPage(lugar: lugar),
    );
  }
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
          if (state.status == PertenenciaStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.listaPertenencias.isEmpty) {
            return const CenterTextForEmptyList('No existen Pertenencias');
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  ReorderableListView.builder(
                    header: const EncabezadoListaPertenencias(),
                    itemCount: state.listaPertenencias.length,
                    shrinkWrap: true,
                    buildDefaultDragHandles:
                        Theme.of(context).platform != TargetPlatform.windows,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return PertenenciaTile(
                        key: Key('P_$index'),
                        pertenencia: state.listaPertenencias[index],
                      );
                    },
                    onReorder: (oldIndex, newIndex) {
                      context.read<PertenenciaBloc>().add(
                            ReorderListaPertenencias(
                              oldIndex: oldIndex,
                              newIndex: newIndex,
                            ),
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
