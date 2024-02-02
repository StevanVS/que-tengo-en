// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:que_tengo_en/domain/entities/lugar.dart';
import 'package:que_tengo_en/domain/entities/objeto.dart';
import 'package:que_tengo_en/ui/pages/objetos/widgets/objeto_tile.dart';

import 'widgets/add_objeto_button.dart';
import 'widgets/encabezado_objetos.dart';

class ObjetosPage extends StatefulWidget {
  const ObjetosPage({super.key, required this.lugar});

  final Lugar lugar;

  @override
  State<ObjetosPage> createState() => _ObjetosPageState();
}

class _ObjetosPageState extends State<ObjetosPage> {
  late List<Objeto> objetos;

  @override
  void initState() {
    super.initState();
    objetos = Objeto.getObjetos();
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
              EncabezadoObjetos(),
              ListView.builder(
                itemCount: objetos.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(top: 7),
                    child: ObjetoTile(objeto: objetos[index]),
                  );
                },
              ),
              AddObjetoButton()
            ],
          ),
        ),
      ),
    );
  }
}
