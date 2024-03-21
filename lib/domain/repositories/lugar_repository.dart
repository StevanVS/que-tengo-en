import 'package:que_tengo_en/domain/entities/lugar.dart';

abstract class LugarRepository {
  const LugarRepository();

  Stream<List<Lugar>> getLugaresStream();

  Future<void> getLugares();

  Future<void> saveLugar(Lugar lugar);

  Future<void> deleteLugar(int id);

  Future<void> reorderListaLugares(int oldIndex, int newIndex);
}

class LugarNotFoundException implements Exception {}
