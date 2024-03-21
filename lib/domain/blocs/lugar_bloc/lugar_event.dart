part of 'lugar_bloc.dart';

sealed class LugarEvent extends Equatable {
  const LugarEvent();

  @override
  List<Object> get props => [];
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

class SubmitLugar extends LugarEvent {
  final Lugar lugar;

  const SubmitLugar(this.lugar);

  @override
  List<Object> get props => [lugar];
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
