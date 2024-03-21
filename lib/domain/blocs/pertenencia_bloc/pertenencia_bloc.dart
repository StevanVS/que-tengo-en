import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:que_tengo_en/domain/entities/lugar.dart';
import 'package:que_tengo_en/domain/entities/pertenencia.dart';
import 'package:que_tengo_en/domain/repositories/pertenencia_repository.dart';

part 'pertenencia_event.dart';
part 'pertenencia_state.dart';

class PertenenciaBloc extends Bloc<PertenenciaEvent, PertenenciaState> {
  final PertenenciaRepository _repository;

  PertenenciaBloc({required PertenenciaRepository pertenenciaRepository})
      : _repository = pertenenciaRepository,
        super(PertenenciaState()) {
    on<SubscribePertenenciasStream>(_onSubscribePertenenciasStream);
    on<GetPertenencias>(_onGetPertenencias);
    on<ResetAllCantidad>(_onResetAllCantidad);
    on<ResetCantidad>(_onResetCantidad);
    on<IncrementCantidad>(_onIncrementCantidad);
    on<CreateOrEditPertenencia>(_onCreateOrEditPertenencia);
    on<SubmitPertenencia>(_onSubmitPertenencia);
    on<DeletePertenencia>(_onDeletePertenencia);
    on<ReorderListaPertenencias>(_onReorderListaPertenencias);
  }

  Future<void> _onSubscribePertenenciasStream(
    SubscribePertenenciasStream event,
    Emitter<PertenenciaState> emit,
  ) async {
    await emit.forEach(
      _repository.getPertenenciasStream(),
      onData: (pertenencias) {
        debugPrint('onData $pertenencias');
        return state.copyWith(
          listaPertenencias: pertenencias,
          status: PertenenciaStatus.success,
        );
      },
      onError: (error, stackTrace) => state.copyWith(
        status: PertenenciaStatus.failure,
      ),
    );
  }

  Future<void> _onGetPertenencias(
    GetPertenencias event,
    Emitter<PertenenciaState> emit,
  ) async {
    emit(state.copyWith(
      pertenencia: () => null,
      lugar: () => event.lugar,
      status: PertenenciaStatus.loading,
    ));

    await _repository.getPertenencias(event.lugar.id!);
  }

  Future<void> _onResetAllCantidad(
    ResetAllCantidad event,
    Emitter<PertenenciaState> emit,
  ) async {
    await _repository.resetAllCantidad(event.tipoCantidad);
  }

  Future<void> _onResetCantidad(
    ResetCantidad event,
    Emitter<PertenenciaState> emit,
  ) async {
    final newPertenencia = event.tipoCantidad == TipoCantidad.enLugar
        ? event.pertenencia.copyWith(cantidadEnLugar: 0)
        : event.pertenencia.copyWith(cantidadParaLlevar: 0);

    await _repository.savePertenencia(newPertenencia);
  }

  Future<void> _onIncrementCantidad(
    IncrementCantidad event,
    Emitter<PertenenciaState> emit,
  ) async {
    final newPertenencia = event.tipoCantidad == TipoCantidad.enLugar
        ? event.pertenencia.copyWith(
            cantidadEnLugar: event.pertenencia.cantidadEnLugar + 1,
          )
        : event.pertenencia.copyWith(
            cantidadParaLlevar: event.pertenencia.cantidadParaLlevar + 1,
          );

    await _repository.savePertenencia(newPertenencia);
  }

  Future<void> _onCreateOrEditPertenencia(
    CreateOrEditPertenencia event,
    Emitter<PertenenciaState> emit,
  ) async {
    print('create or edit ${event.pertenencia}');
    emit(state.copyWith(pertenencia: () => event.pertenencia));
  }

  Future<void> _onSubmitPertenencia(
    SubmitPertenencia event,
    Emitter<PertenenciaState> emit,
  ) async {
    emit(state.copyWith(status: PertenenciaStatus.loading));

    final pertenencia = state.pertenencia != null
        ? state.pertenencia!.copyWith(
            nombre: event.nombre,
            cantidadEnLugar: event.cantidadEnLugar,
            cantidadParaLlevar: event.cantidadParaLlevar)
        : Pertenencia(
            lugarId: state.lugar!.id!,
            nombre: event.nombre,
            cantidadEnLugar: event.cantidadEnLugar,
            cantidadParaLlevar: event.cantidadParaLlevar);

    try {
      await _repository.savePertenencia(pertenencia);
      emit(state.copyWith(status: PertenenciaStatus.success));
    } catch (e) {
      emit(state.copyWith(status: PertenenciaStatus.failure));
    }
  }

  Future<void> _onDeletePertenencia(
    DeletePertenencia event,
    Emitter<PertenenciaState> emit,
  ) async {
    await _repository.deletePertenencia(event.id);
  }

  Future<void> _onReorderListaPertenencias(
    ReorderListaPertenencias event,
    Emitter<PertenenciaState> emit,
  ) async {
    await _repository.reorderListaPertenencias(event.oldIndex, event.newIndex);
  }
}
