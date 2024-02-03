// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:que_tengo_en/domain/entities/lugar.dart';
import 'package:que_tengo_en/domain/entities/pertenencia.dart';
import 'package:que_tengo_en/ui/pages/pertenencias/widgets/pertenencia_tile.dart';

import 'widgets/encabezado_lista_pertenencias.dart';
import 'widgets/pertenencia_modal.dart';

class PertenenciasPage extends StatefulWidget {
  const PertenenciasPage({super.key, required this.lugar});

  final Lugar lugar;

  @override
  State<PertenenciasPage> createState() => _PertenenciasPageState();
}

class _PertenenciasPageState extends State<PertenenciasPage> {
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
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 5),
              EncabezadoListaPertenencias(),
              ListView.builder(
                itemCount: pertenencias.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(top: 7),
                    child: PertenenciaTile(pertenencia: pertenencias[index]),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          PertenenciaModal.mostrarPertenenciaModal(context, null);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
