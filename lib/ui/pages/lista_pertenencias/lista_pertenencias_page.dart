import 'package:flutter/material.dart';
import 'package:que_tengo_en/domain/entities/lugar.dart';
import 'package:que_tengo_en/domain/entities/pertenencia.dart';
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
  late List<Pertenencia> pertenencias;

  @override
  void initState() {
    super.initState();
    pertenencias = Pertenencia.getPertenencias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.lugar.nombre),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const EncabezadoListaPertenencias(),
              const SizedBox(height: 8),
              ListView.builder(
                itemCount: pertenencias.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return PertenenciaListTile(pertenencia: pertenencias[index]);
                },
              ),
            ],
          ),
        ),
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
