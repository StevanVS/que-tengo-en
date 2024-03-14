import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:que_tengo_en/domain/entities/lugar.dart';
// import 'package:meta/meta.dart';
import 'package:que_tengo_en/domain/entities/pertenencia.dart';

part 'pertenencia_event.dart';
part 'pertenencia_state.dart';

class PertenenciaBloc extends Bloc<PertenenciaEvent, PertenenciaState> {
  PertenenciaBloc() : super(PertenenciaState()) {
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
    emit(state.copyWith(pertenenciaStatus: PertenenciaStatus.loading));
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(lugar: () => event.lugar, pertenenciaStatus: PertenenciaStatus.success));
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
    final listaPertenencias = [...state.listaPertenencias];
    final newListaPertenencias = listaPertenencias.map((p) {
      return event.tipoCantidad == TipoCantidad.enLugar
          ? p.copyWith(cantidadEnLugar: 0)
          : p.copyWith(cantidadParaLlevar: 0);
    }).toList();

    emit(state.copyWith(listaPertenencias: newListaPertenencias));
  }

  Future<void> _onResetCantidad(
    ResetCantidad event,
    Emitter<PertenenciaState> emit,
  ) async {
    final listaPertenencias = [...state.listaPertenencias];
    final index = listaPertenencias.indexWhere((p) => p.id == event.pertenencia.id);
    final pertenencia = state.listaPertenencias[index];

    if (index == -1) {
      throw ErrorDescription('no hay pertenencia');
    }

    listaPertenencias[index] = event.tipoCantidad == TipoCantidad.enLugar
        ? pertenencia.copyWith(cantidadEnLugar: 0)
        : pertenencia.copyWith(cantidadParaLlevar: 0);

    emit(state.copyWith(listaPertenencias: listaPertenencias));
  }

  Future<void> _onIncrementCantidad(
    IncrementCantidad event,
    Emitter<PertenenciaState> emit,
  ) async {
    final listaPertenencias = [...state.listaPertenencias];
    final index = listaPertenencias.indexWhere((p) => p.id == event.pertenencia.id);
    final pertenencia = state.listaPertenencias[index];

    if (index == -1) {
      throw ErrorDescription('no hay pertenencia');
    }

    listaPertenencias[index] = event.tipoCantidad == TipoCantidad.enLugar
        ? pertenencia.copyWith(cantidadEnLugar: pertenencia.cantidadEnLugar + 1)
        : pertenencia.copyWith(
            cantidadParaLlevar: pertenencia.cantidadParaLlevar + 1);

    emit(state.copyWith(listaPertenencias: listaPertenencias));
  }

  Future<void> _onSubmitPertenencia(
    SubmitPertenencia event,
    Emitter<PertenenciaState> emit,
  ) async {
    final listaPertenencias = [...state.listaPertenencias];
    final index = listaPertenencias.indexWhere((p) => p.id == event.pertenencia.id);

    if (index >= 0) {
      listaPertenencias[index] = event.pertenencia;
    } else {
      late int id;
      if (listaPertenencias.isNotEmpty) {
        id = listaPertenencias.map<int>((p) => p.id ?? 0).toList().reduce(max) +
            1;
      } else {
        id = 1;
      }

      listaPertenencias.add(event.pertenencia.copyWith(id: () => id));
    }

    emit(state.copyWith(listaPertenencias: listaPertenencias));
  }

  Future<void> _onDeletePertenencia(
    DeletePertenencia event,
    Emitter<PertenenciaState> emit,
  ) async {
    final listaPertenencias = [...state.listaPertenencias];
    final index = listaPertenencias.indexWhere((p) => p.id == event.pertenencia.id);

    if (index == -1) {
      throw ErrorDescription('no hay pertenencia');
    }

    listaPertenencias.removeAt(index);
    emit(state.copyWith(listaPertenencias: listaPertenencias));
  }
}
