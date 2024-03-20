import 'package:flutter/material.dart';
import 'package:que_tengo_en/domain/entities/lugar.dart';
import 'package:que_tengo_en/ui/pages/lista_lugares/widgets/lugar_tile.dart';
import 'package:que_tengo_en/ui/pages/modal_lugar/modal_lugar.dart';

class ListaLugaresPage extends StatefulWidget {
  const ListaLugaresPage({super.key});

  @override
  State<ListaLugaresPage> createState() => _ListaLugaresPageState();
}

class _ListaLugaresPageState extends State<ListaLugaresPage> {
  late List<Lugar> _lugares;

  @override
  void initState() {
    super.initState();
    setState(() {
      _lugares = Lugar.getLugares();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Que tengo en'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          itemCount: _lugares.length,
          itemBuilder: (BuildContext context, int index) {
            return LugarTile(lugar: _lugares[index]);
          },
        ),
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
