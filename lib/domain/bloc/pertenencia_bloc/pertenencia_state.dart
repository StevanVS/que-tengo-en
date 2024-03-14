part of 'pertenencia_bloc.dart';

enum TipoCantidad { paraLlevar, enLugar }

enum PertenenciaStatus { initial, loading, success, failure }

class PertenenciaState {
  final Lugar? lugar;
  final Pertenencia? pertenencia;
  final List<Pertenencia> listaPertenencias;
  final PertenenciaStatus pertenenciaStatus;

  PertenenciaState({
    this.lugar,
    this.pertenencia,
    this.listaPertenencias = const [],
    this.pertenenciaStatus = PertenenciaStatus.initial
  });
  

  PertenenciaState copyWith({
    ValueGetter<Lugar?>? lugar,
    ValueGetter<Pertenencia?>? pertenencia,
    List<Pertenencia>? listaPertenencias,
    PertenenciaStatus? pertenenciaStatus,
  }) {
    return PertenenciaState(
      lugar: lugar != null ? lugar() : this.lugar,
      pertenencia: pertenencia != null ? pertenencia() : this.pertenencia,
      listaPertenencias: listaPertenencias ?? this.listaPertenencias,
      pertenenciaStatus: pertenenciaStatus ?? this.pertenenciaStatus,
    );
  }
}
