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
    on<SubscribeLugaresStream>(_onSubscribeLugaresStream);
    on<GetLugares>(_onGetLugares);
    on<ToggleFavorito>(_onToggleFavorito);
    on<CreateOrEditLugar>(_onCreateOrEditLugar);
    on<SubmitLugar>(_onSubmitLugar);
    on<DeleteLugar>(_onDeleteLugar);
    on<ReorderListaLugares>(_onReorderListaLugares);
  }

  Future<void> _onSubscribeLugaresStream(
    SubscribeLugaresStream event,
    Emitter<LugarState> emit,
  ) async {
    await emit.forEach<List<Lugar>>(
      _repository.getLugaresStream(),
      onData: (listaLugares) => state.copyWith(
        listaLugares: listaLugares,
        status: LugarStatus.success,
      ),
      onError: (_, __) => state.copyWith(
        status: LugarStatus.failure,
      ),
    );
  }

  Future<void> _onGetLugares(
    GetLugares event,
    Emitter<LugarState> emit,
  ) async {
    emit(state.copyWith(lugar: null, status: LugarStatus.loading));

    await _repository.getLugares();
  }

  Future<void> _onToggleFavorito(
    ToggleFavorito event,
    Emitter<LugarState> emit,
  ) async {
    final lugar = event.lugar.copyWith(favorito: !event.lugar.favorito);

    _repository.saveLugar(lugar);
  }

  Future<void> _onCreateOrEditLugar(
    CreateOrEditLugar event,
    Emitter<LugarState> emit,
  ) async {
    emit(state.copyWith(lugar: () => event.lugar));
  }

  Future<void> _onSubmitLugar(
    SubmitLugar event,
    Emitter<LugarState> emit,
  ) async {
    emit(state.copyWith(status: LugarStatus.loading));

    final lugar = (state.lugar ?? const Lugar()).copyWith(nombre: event.nombre);

    try {
      await _repository.saveLugar(lugar);
      emit(state.copyWith(status: LugarStatus.success, lugar: null));
    } catch (e) {
      emit(state.copyWith(status: LugarStatus.failure));
    }
  }

  Future<void> _onDeleteLugar(
    DeleteLugar event,
    Emitter<LugarState> emit,
  ) async {
    await _repository.deleteLugar(event.id);
  }

  Future<void> _onReorderListaLugares(
    ReorderListaLugares event,
    Emitter<LugarState> emit,
  ) async {
    await _repository.reorderListaLugares(event.oldIndex, event.newIndex);
  }
}
