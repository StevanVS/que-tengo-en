import 'package:injector/injector.dart';
import 'package:que_tengo_en/domain/blocs/blocs.dart';
import 'package:que_tengo_en/domain/repositories/pertenencia_repository.dart';

class BlocsRegister {
  final injector = Injector.appInstance;

  BlocsRegister() {
    injector.registerSingleton<PertenenciaBloc>(
      () => PertenenciaBloc(pertenenciaRepository: injector.get<PertenenciaRepository>()),
    );
  }
}
