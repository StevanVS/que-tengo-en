import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:que_tengo_en/domain/blocs/blocs.dart';
import 'package:que_tengo_en/domain/blocs/lugar_bloc/lugar_bloc.dart';
import 'package:que_tengo_en/ui/pages/lista_lugares/widgets/lugar_tile.dart';
import 'package:que_tengo_en/ui/pages/modal_lugar/modal_lugar.dart';
import 'package:que_tengo_en/ui/widgets/center_text_list_empty.dart';

class ListaLugaresPage extends StatefulWidget {
  const ListaLugaresPage({super.key});

  @override
  State<ListaLugaresPage> createState() => _ListaLugaresPageState();
}

class _ListaLugaresPageState extends State<ListaLugaresPage> {
  @override
  void initState() {
    super.initState();
    context.read<LugarBloc>().add(const GetLugares());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Que tengo en'),
      ),
      body: BlocConsumer<LugarBloc, LugarState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == LugarStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.listaLugares.isEmpty) {
            return const CenterTextForEmptyList('No existen Lugares');
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ReorderableListView.builder(
              itemCount: state.listaLugares.length,
              buildDefaultDragHandles:
                  Theme.of(context).platform != TargetPlatform.windows,
              itemBuilder: (BuildContext context, int index) {
                return LugarTile(
                  key: Key('L_$index'),
                  lugar: state.listaLugares[index],
                );
              },
              onReorder: (oldIndex, newIndex) {
                context.read<LugarBloc>().add(ReorderListaLugares(
                      oldIndex: oldIndex,
                      newIndex: newIndex,
                    ));
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ModalLugar.mostrarLugarModal(context, null);
        },
        child: const Icon(Icons.add_location_alt_rounded),
      ),
    );
  }
}
