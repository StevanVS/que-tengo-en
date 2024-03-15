part of 'pertenencia_bloc.dart';

@immutable
sealed class PertenenciaEvent extends Equatable {
  const PertenenciaEvent();
  @override
  List<Object> get props => [];
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

  const IncrementCantidad({required this.pertenencia, required this.tipoCantidad});

  @override
  List<Object> get props => [pertenencia, tipoCantidad];
}

class SubmitPertenencia extends PertenenciaEvent {
  final Pertenencia pertenencia;

  const SubmitPertenencia(this.pertenencia);

  @override
  List<Object> get props => [pertenencia];
}

class DeletePertenencia extends PertenenciaEvent {
  final int id;

  const DeletePertenencia(this.id);

  @override
  List<Object> get props => [id];
}
