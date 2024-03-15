import 'package:que_tengo_en/domain/blocs/blocs.dart';
import 'package:que_tengo_en/domain/entities/pertenencia.dart';

abstract class PertenenciaRepository {
  const PertenenciaRepository();

  Stream<List<Pertenencia>> getPertenenciasStream();

  Future<void> savePertenencia(Pertenencia pertenencia);

  Future<void> deletePertenencia(int id);

  Future<void> resetAllCantidad(TipoCantidad tipoCantidad);
}

class PertenenciaNotFoundException implements Exception {}