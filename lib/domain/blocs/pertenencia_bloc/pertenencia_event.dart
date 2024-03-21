part of 'pertenencia_bloc.dart';

@immutable
sealed class PertenenciaEvent extends Equatable {
  const PertenenciaEvent();
  @override
  List<Object?> get props => [];
}

class SubscribePertenenciasStream extends PertenenciaEvent {
  const SubscribePertenenciasStream();
}

class GetPertenencias extends PertenenciaEvent {
  final Lugar lugar;

  const GetPertenencias({required this.lugar});

  @override
  List<Object> get props => [lugar];
}

class ResetAllCantidad extends PertenenciaEvent {
  final TipoCantidad tipoCantidad;

  const ResetAllCantidad({required this.tipoCantidad});

  @override
  List<Object> get props => [tipoCantidad];
}

class ResetCantidad extends PertenenciaEvent {
  final Pertenencia pertenencia;
  final TipoCantidad tipoCantidad;

  const ResetCantidad({required this.pertenencia, required this.tipoCantidad});

  @override
  List<Object> get props => [pertenencia, tipoCantidad];
}

class IncrementCantidad extends PertenenciaEvent {
  final Pertenencia pertenencia;
  final TipoCantidad tipoCantidad;

  const IncrementCantidad({
    required this.pertenencia,
    required this.tipoCantidad,
  });

  @override
  List<Object> get props => [pertenencia, tipoCantidad];
}

class CreateOrEditPertenencia extends PertenenciaEvent {
  final Pertenencia? pertenencia;

  const CreateOrEditPertenencia(this.pertenencia);

  @override
  List<Object?> get props => [pertenencia];
}

class SubmitPertenencia extends PertenenciaEvent {
  final String nombre;
  final int cantidadEnLugar;
  final int cantidadParaLlevar;

  const SubmitPertenencia({
    required this.nombre,
    required this.cantidadEnLugar,
    required this.cantidadParaLlevar,
  });

  @override
  List<Object> get props => [nombre, cantidadEnLugar, cantidadParaLlevar];
}

class DeletePertenencia extends PertenenciaEvent {
  final int id;

  const DeletePertenencia(this.id);

  @override
  List<Object> get props => [id];
}

class ReorderListaPertenencias extends PertenenciaEvent {
  final int oldIndex;
  final int newIndex;

  const ReorderListaPertenencias({
    required this.oldIndex,
    required this.newIndex,
  });

  @override
  List<Object> get props => [oldIndex, newIndex];
}
