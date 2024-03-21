import 'package:hive_flutter/hive_flutter.dart';
import 'package:injector/injector.dart';
import 'package:que_tengo_en/data/repositories/hive_lugar_repository.dart';

import 'package:que_tengo_en/data/repositories/hive_pertenencia_repository.dart';
import 'package:que_tengo_en/domain/repositories/lugar_repository.dart';
import 'package:que_tengo_en/domain/repositories/pertenencia_repository.dart';

class RepositoriesRegister {
  final injector = Injector.appInstance;

  static const kDataBaseKey = '__QUE_TENGO_EN_DB_KEY__';

  RepositoriesRegister();

  Future<void> register() async {
    final box = await Hive.openBox<String>(kDataBaseKey);

    injector.registerSingleton<PertenenciaRepository>(
      () => HivePertenenciaRepository(box: box),
    );

    injector.registerSingleton<LugarRepository>(
      () => HiveLugarRepository(
        box: box,
        pertenenciaRepositry: injector.get<PertenenciaRepository>(),
      ),
    );
  }
}
