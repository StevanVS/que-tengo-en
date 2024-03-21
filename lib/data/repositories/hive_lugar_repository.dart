import 'dart:convert';
import 'dart:math';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:que_tengo_en/domain/entities/lugar.dart';
import 'package:que_tengo_en/domain/repositories/lugar_repository.dart';
import 'package:rxdart/rxdart.dart';

class HiveLugarRepository implements LugarRepository {
  final _lugarStreamController = BehaviorSubject<List<Lugar>>.seeded(const []);

  final Box<String> _lugarBox;

  static const kLugarStorageKey = '__LUGAR_STORAGE_KEY__';

  HiveLugarRepository({required Box<String> box}) : _lugarBox = box {
    // _init();
  }

  _init() async {
    final lugaresJson = _lugarBox.get(kLugarStorageKey);

    if (lugaresJson != null) {
      final lugares = (json.decode(lugaresJson) as List)
          .map((p) => Lugar.fromJson(p))
          .toList();
      _lugarStreamController.add(lugares);
    } else {
      _lugarStreamController.add(const []);
    }
  }

  @override
  Stream<List<Lugar>> getLugaresStream() =>
      _lugarStreamController.asBroadcastStream();

  @override
  Future<void> saveLugar(Lugar lugar) async {
    final listaLugares = [..._lugarStreamController.value];
    final index = listaLugares.indexWhere((p) => p.id == lugar.id);

    if (index >= 0) {
      listaLugares[index] = lugar;
    } else {
      late int id;
      if (listaLugares.isNotEmpty) {
        id = listaLugares.map<int>((p) => p.id ?? 0).toList().reduce(max);
      } else {
        id = 0;
      }
      listaLugares.add(lugar.copyWith(id: () => id + 1));
    }

    _lugarStreamController.add(listaLugares);
    // await _lugarBox.put(kLugarStorageKey, json.encode(listaLugares));
  }

  @override
  Future<void> deleteLugar(int id) async {
    final listaLugares = [..._lugarStreamController.value];
    final index = listaLugares.indexWhere((p) => p.id == id);

    if (index == -1) {
      throw LugarNotFoundException();
    }

    listaLugares.removeAt(index);

    _lugarStreamController.add(listaLugares);
    await _lugarBox.put(kLugarStorageKey, json.encode(listaLugares));
  }
}
