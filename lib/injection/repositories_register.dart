import 'package:injector/injector.dart';
import 'package:que_tengo_en/data/repositories/hive_pertenencia_repository.dart';
import 'package:que_tengo_en/domain/repositories/pertenencia_repository.dart';

class RepositoriesRegister {
  final injector = Injector.appInstance;

  RepositoriesRegister() {
    injector.registerDependency<PertenenciaRepository>(() => HivePertenenciaRepository());
  }
}