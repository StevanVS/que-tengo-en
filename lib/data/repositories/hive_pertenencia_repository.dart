import 'dart:convert';
import 'dart:math';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:que_tengo_en/domain/blocs/pertenencia_bloc/pertenencia_bloc.dart';
import 'package:que_tengo_en/domain/entities/pertenencia.dart';
import 'package:que_tengo_en/domain/repositories/pertenencia_repository.dart';
import 'package:rxdart/rxdart.dart';

class HivePertenenciaRepository implements PertenenciaRepository {
  final _pertenenciaStreamController =
      BehaviorSubject<List<Pertenencia>>.seeded(const []);

  final Box<String> _box;

  static const kPertenenciaDataBaseKey = '__PERTENENCIA_DB_KEY__';
  static const kPertenenciaStorageKey = '__PERTENENCIA_STORAGE_KEY__';

  HivePertenenciaRepository({required Box<String> box}) : _box = box {
    _init();
  }

  _init() async {
    final pertenenciaJson = _box.get(kPertenenciaStorageKey);

    if (pertenenciaJson != null) {
      final pertenencias = (json.decode(pertenenciaJson) as List)
          .map((p) => Pertenencia.fromJson(p))
          .toList();
      _pertenenciaStreamController.add(pertenencias);
    } else {
      _pertenenciaStreamController.add(const []);
    }
  }

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
    await _box.put(kPertenenciaStorageKey, json.encode(listaPertenencias));
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
    await _box.put(kPertenenciaStorageKey, json.encode(listaPertenencias));
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
    await _box.put(kPertenenciaStorageKey, json.encode(listaPertenencias));
  }
}
