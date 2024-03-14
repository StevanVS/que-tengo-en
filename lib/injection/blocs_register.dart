import 'package:injector/injector.dart';
import 'package:que_tengo_en/domain/bloc/bloc.dart';

class BlocsRegister {
  final injector = Injector.appInstance;

  BlocsRegister() {
    injector.registerSingleton<PertenenciaBloc>(() => PertenenciaBloc());
  }
}