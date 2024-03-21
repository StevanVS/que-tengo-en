part of 'lugar_bloc.dart';

sealed class LugarEvent extends Equatable {
  const LugarEvent();

  @override
  List<Object?> get props => [];
}

class SubscribeLugaresStream extends LugarEvent {
  const SubscribeLugaresStream();
}

class GetLugares extends LugarEvent {
  const GetLugares();
}

class ToggleFavorito extends LugarEvent {
  final Lugar lugar;

  const ToggleFavorito(this.lugar);

  @override
  List<Object> get props => [lugar];
}

class CreateOrEditLugar extends LugarEvent {
  final Lugar? lugar;

  const CreateOrEditLugar(this.lugar);

  @override
  List<Object?> get props => [lugar];
}

class SubmitLugar extends LugarEvent {
  final String nombre;

  const SubmitLugar(this.nombre);

  @override
  List<Object> get props => [nombre];
}

class DeleteLugar extends LugarEvent {
  final int id;

  const DeleteLugar(this.id);

  @override
  List<Object> get props => [id];
}

class ReorderListaLugares extends LugarEvent {
  final int oldIndex;
  final int newIndex;

  const ReorderListaLugares({
    required this.oldIndex,
    required this.newIndex,
  });

  @override
  List<Object> get props => [oldIndex, newIndex];
}
