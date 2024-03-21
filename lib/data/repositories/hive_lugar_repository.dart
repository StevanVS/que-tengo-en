import 'dart:convert';
import 'dart:math';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:que_tengo_en/domain/entities/lugar.dart';
import 'package:que_tengo_en/domain/repositories/lugar_repository.dart';
import 'package:que_tengo_en/domain/repositories/pertenencia_repository.dart';
import 'package:rxdart/rxdart.dart';

class HiveLugarRepository implements LugarRepository {
  final _lugarStreamController = BehaviorSubject<List<Lugar>>();

  final Box<String> _box;
  final PertenenciaRepository _pertenenciaRepository;

  static const kLugarStorageKey = '__LUGAR_STORAGE_KEY__';

  HiveLugarRepository({
    required Box<String> box,
    required PertenenciaRepository pertenenciaRepositry,
  })  : _box = box,
        _pertenenciaRepository = pertenenciaRepositry;

  _saveLista(List<Lugar> listaLugares) async {
    _lugarStreamController.add(listaLugares);
    await _box.put(kLugarStorageKey, json.encode(listaLugares));
  }

  @override
  Stream<List<Lugar>> getLugaresStream() =>
      _lugarStreamController.asBroadcastStream();

  @override
  Future<void> getLugares() async {
    _lugarStreamController.drain();
    final lugaresJson = _box.get(kLugarStorageKey);

    if (lugaresJson != null) {
      final lugares = (json.decode(lugaresJson) as List)
          .map((l) => Lugar.fromJson(l))
          .toList();
      _lugarStreamController.add(lugares);
    } else {
      _lugarStreamController.add(const []);
    }
  }

  @override
  Future<void> saveLugar(Lugar lugar) async {
    final listaLugares = [..._lugarStreamController.value];
    final index = listaLugares.indexWhere((l) => l.id == lugar.id);

    if (index >= 0) {
      listaLugares[index] = lugar;
    } else {
      late int id;
      if (listaLugares.isNotEmpty) {
        id = listaLugares.map<int>((l) => l.id).toList().reduce(max);
      } else {
        id = 0;
      }
      listaLugares.add(lugar.copyWith(id: id + 1));
    }

    await _saveLista(listaLugares);
  }

  @override
  Future<void> deleteLugar(int id) async {
    final listaLugares = [..._lugarStreamController.value];
    final index = listaLugares.indexWhere((l) => l.id == id);

    if (index == -1) {
      throw LugarNotFoundException();
    }

    _pertenenciaRepository.deleteAllPertenencias(id);

    listaLugares.removeAt(index);

    await _saveLista(listaLugares);
  }

  @override
  Future<void> reorderListaLugares(int oldIndex, int newIndex) async {
    final listaLugares = [..._lugarStreamController.value];

    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final lugar = listaLugares.removeAt(oldIndex);
    listaLugares.insert(newIndex, lugar);

    await _saveLista(listaLugares);
  }
}
