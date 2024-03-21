import 'package:injector/injector.dart';
import 'package:que_tengo_en/domain/blocs/blocs.dart';
import 'package:que_tengo_en/domain/repositories/lugar_repository.dart';
import 'package:que_tengo_en/domain/repositories/pertenencia_repository.dart';

class BlocsRegister {
  final injector = Injector.appInstance;

  BlocsRegister() {
    injector.registerSingleton<LugarBloc>(
      () => LugarBloc(
        repository: injector.get<LugarRepository>(),
      ),
    );

    injector.registerSingleton<PertenenciaBloc>(
      () => PertenenciaBloc(
        repository: injector.get<PertenenciaRepository>(),
      ),
    );

  }
}
