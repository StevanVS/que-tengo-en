import 'package:que_tengo_en/domain/entities/lugar.dart';

abstract class LugarRepository {
  const LugarRepository();

  Stream<List<Lugar>> getLugaresStream();

  Future<void> saveLugar(Lugar lugar);

  Future<void> deleteLugar(int id);
}

class LugarNotFoundException implements Exception {}
