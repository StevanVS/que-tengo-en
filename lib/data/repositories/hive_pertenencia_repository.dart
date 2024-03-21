import 'dart:convert';
import 'dart:math';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:que_tengo_en/domain/blocs/pertenencia_bloc/pertenencia_bloc.dart';
import 'package:que_tengo_en/domain/entities/pertenencia.dart';
import 'package:que_tengo_en/domain/repositories/pertenencia_repository.dart';
import 'package:rxdart/rxdart.dart';

class HivePertenenciaRepository implements PertenenciaRepository {
  final _pertenenciaStreamController = BehaviorSubject<List<Pertenencia>>();

  final Box<String> _box;

  static const kPertenenciaStorageKey = '__PERTENENCIA_STORAGE_KEY__';
  String _kPertenenciasLugarStorageKey = '';

  HivePertenenciaRepository({required Box<String> box}) : _box = box;

  _saveLista(List<Pertenencia> listaPertenencias) async {
    _pertenenciaStreamController.add(listaPertenencias);
    await _box.put(
      _kPertenenciasLugarStorageKey,
      json.encode(listaPertenencias),
    );
  }

  @override
  Stream<List<Pertenencia>> getPertenenciasStream() =>
      _pertenenciaStreamController.asBroadcastStream();

  @override
  Future<void> getPertenencias(int lugarId) async {
    _pertenenciaStreamController.drain();

    _kPertenenciasLugarStorageKey =
        '${kPertenenciaStorageKey}__LUGAR__${lugarId}__';

    final pertenenciaJson = _box.get(_kPertenenciasLugarStorageKey);

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
  Future<void> savePertenencia(Pertenencia pertenencia) async {
    final listaPertenencias = [..._pertenenciaStreamController.value];
    final index = listaPertenencias.indexWhere((p) => p.id == pertenencia.id);

    if (index >= 0) {
      listaPertenencias[index] = pertenencia;
    } else {
      late int id;
      if (listaPertenencias.isNotEmpty) {
        id = listaPertenencias.map<int>((p) => p.id).toList().reduce(max);
      } else {
        id = 0;
      }
      listaPertenencias.add(pertenencia.copyWith(id: id + 1));
    }

    await _saveLista(listaPertenencias);
  }

  @override
  Future<void> deletePertenencia(int id) async {
    final listaPertenencias = [..._pertenenciaStreamController.value];
    final index = listaPertenencias.indexWhere((p) => p.id == id);

    if (index == -1) {
      throw PertenenciaNotFoundException();
    }

    listaPertenencias.removeAt(index);

    await _saveLista(listaPertenencias);
  }

  @override
  Future<void> deleteAllPertenencias(int lugarId) async {
    _kPertenenciasLugarStorageKey =
        '${kPertenenciaStorageKey}__LUGAR__${lugarId}__';

    await _box.delete(_kPertenenciasLugarStorageKey);
    _pertenenciaStreamController.drain();
  }

  @override
  Future<void> resetAllCantidad(TipoCantidad tipoCantidad) async {
    final listaPertenencias = [..._pertenenciaStreamController.value];

    final newListaPertenencias = listaPertenencias.map((p) {
      return tipoCantidad == TipoCantidad.enLugar
          ? p.copyWith(cantidadEnLugar: 0)
          : p.copyWith(cantidadParaLlevar: 0);
    }).toList();

    await _saveLista(newListaPertenencias);
  }

  @override
  Future<void> reorderListaPertenencias(int oldIndex, int newIndex) async {
    final listaPertenencias = [..._pertenenciaStreamController.value];

    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final pertenencia = listaPertenencias.removeAt(oldIndex);
    listaPertenencias.insert(newIndex, pertenencia);

    await _saveLista(listaPertenencias);
  }
}
