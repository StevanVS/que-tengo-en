import 'dart:math';

import 'package:que_tengo_en/domain/blocs/pertenencia_bloc/pertenencia_bloc.dart';
import 'package:que_tengo_en/domain/entities/pertenencia.dart';
import 'package:que_tengo_en/domain/repositories/pertenencia_repository.dart';
import 'package:rxdart/rxdart.dart';

class HivePertenenciaRepository implements PertenenciaRepository {
  final _pertenenciaStreamController =
      BehaviorSubject<List<Pertenencia>>.seeded(const []);

  @override
  Stream<List<Pertenencia>> getPertenenciasStream() {
    return _pertenenciaStreamController.asBroadcastStream();
  }

  @override
  Future<void> savePertenencia(Pertenencia pertenencia) async {
    final listaPertenencias = [..._pertenenciaStreamController.value];
    final index = listaPertenencias.indexWhere((p) => p.id == pertenencia.id);

    if (index >= 0) {
      listaPertenencias[index] = pertenencia;
    } else {
      late int id;
      if (listaPertenencias.isNotEmpty) {
        id = listaPertenencias.map<int>((p) => p.id ?? 0).toList().reduce(max);
      } else {
        id = 0;
      }

      listaPertenencias.add(pertenencia.copyWith(id: () => id + 1));
    }
    _pertenenciaStreamController.add(listaPertenencias);
  }

  @override
  Future<void> deletePertenencia(int id) async {
    final listaPertenencias = [..._pertenenciaStreamController.value];
    final index = listaPertenencias.indexWhere((p) => p.id == id);

    if (index == -1) {
      throw PertenenciaNotFoundException();
    }

    listaPertenencias.removeAt(index);

    _pertenenciaStreamController.add(listaPertenencias);
  }

  @override
  Future<void> resetAllCantidad(TipoCantidad tipoCantidad) async {
    final listaPertenencias = [..._pertenenciaStreamController.value];

    final newListaPertenencias = listaPertenencias.map((p) {
      return tipoCantidad == TipoCantidad.enLugar
          ? p.copyWith(cantidadEnLugar: 0)
          : p.copyWith(cantidadParaLlevar: 0);
    }).toList();

    _pertenenciaStreamController.add(newListaPertenencias);
  }
}
