part of 'lugar_bloc.dart';

enum LugarStatus { initial, loading, success, failure }

class LugarState extends Equatable {
  final Lugar? lugar;
  final List<Lugar> listaLugares;
  final LugarStatus status;

  const LugarState({
    this.lugar,
    this.listaLugares = const [],
    this.status = LugarStatus.initial,
  });

  bool get esNuevoLugar => lugar == null;

  @override
  List<Object?> get props => [lugar, listaLugares, status];

  LugarState copyWith({
    ValueGetter<Lugar?>? lugar,
    List<Lugar>? listaLugares,
    LugarStatus? status,
  }) {
    return LugarState(
      lugar: lugar != null ? lugar() : this.lugar,
      listaLugares: listaLugares ?? this.listaLugares,
      status: status ?? this.status,
    );
  }
}
