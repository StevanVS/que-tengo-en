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
    on<GetPertenencias>(_onGetPertenencias);
    on<ResetAllCantidad>(_onResetAllCantidad);
    on<ResetCantidad>(_onResetCantidad);
    on<IncrementCantidad>(_onIncrementCantidad);
    on<SubmitPertenencia>(_onSubmitPertenencia);
    on<DeletePertenencia>(_onDeletePertenencia);
  }

  Future<void> _onGetPertenencias(
    GetPertenencias event,
    Emitter<PertenenciaState> emit,
  ) async {
    emit(state.copyWith(
      lugar: () => event.lugar,
      status: PertenenciaStatus.loading,
    ));

    // await Future.delayed(const Duration(seconds: 1));

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

    // emit(
    //   state.copyWith(
    //     lugar: () => event.lugar,
    //     listaPertenencias: const [
    //       Pertenencia(
    //         id: 1,
    //         lugarId: 1,
    //         nombre: 'Pantalon',
    //         cantidadEnLugar: 1,
    //         cantidadParaLlevar: 5,
    //       ),
    //       Pertenencia(
    //         id: 2,
    //         lugarId: 1,
    //         nombre: 'Camiseta formal',
    //         cantidadEnLugar: 0,
    //         cantidadParaLlevar: 2,
    //       ),
    //       Pertenencia(
    //         id: 3,
    //         lugarId: 1,
    //         nombre: 'Camiseta sencilla',
    //         cantidadEnLugar: 2,
    //         cantidadParaLlevar: 0,
    //       ),
    //       // Pertenencia(
    //       //   id: 4,
    //       //   lugarId: 1,
    //       //   nombre: 'Interiores',
    //       //   cantidadEnLugar: 1,
    //       //   cantidadParaLlevar: 3,
    //       // ),
    //     ],
    //   ),
    // );
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

  Future<void> _onSubmitPertenencia(
    SubmitPertenencia event,
    Emitter<PertenenciaState> emit,
  ) async {
    emit(state.copyWith(status: PertenenciaStatus.loading));

    try {
      await _repository.savePertenencia(event.pertenencia);
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
}
