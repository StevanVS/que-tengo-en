import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:que_tengo_en/domain/entities/lugar.dart';
import 'package:que_tengo_en/domain/repositories/lugar_repository.dart';

part 'lugar_event.dart';
part 'lugar_state.dart';

class LugarBloc extends Bloc<LugarEvent, LugarState> {
  final LugarRepository _repository;

  LugarBloc({required LugarRepository repository})
      : _repository = repository,
        super(const LugarState()) {
    on<GetLugares>(_onGetLugares);
    on<ToggleFavorito>(_onToggleFavorito);
    on<SubmitLugar>(_onSubmitLugar);
    on<DeleteLugar>(_onDeleteLugar);
    on<ReorderListaLugares>(_onReorderListaLugares);
  }

  Future<void> _onGetLugares(
    GetLugares event,
    Emitter<LugarState> emit,
  ) async {
    emit(state.copyWith(status: LugarStatus.loading));
    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(
      status: LugarStatus.success,
      listaLugares: [
        Lugar(id: 1, nombre: 'Portoviejo', favorito: true),
        Lugar(id: 2, nombre: 'Manta', favorito: false),
      ],
    ));
  }

  Future<void> _onToggleFavorito(
    ToggleFavorito event,
    Emitter<LugarState> emit,
  ) async {
    final lugar = event.lugar.copyWith(
      favorito: !event.lugar.favorito,
      ultimoEditado: () => DateTime.now(),
    );
    _repository.saveLugar(lugar);
  }

  Future<void> _onSubmitLugar(
    SubmitLugar event,
    Emitter<LugarState> emit,
  ) async {}

  Future<void> _onDeleteLugar(
    DeleteLugar event,
    Emitter<LugarState> emit,
  ) async {}

  Future<void> _onReorderListaLugares(
    ReorderListaLugares event,
    Emitter<LugarState> emit,
  ) async {}
}
