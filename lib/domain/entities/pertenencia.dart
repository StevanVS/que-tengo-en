import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class Pertenencia extends Equatable {
  final int? id;
  final int lugarId;
  final String nombre;
  final int cantidadEnLugar;
  final int cantidadParaLlevar;

  const Pertenencia({
    this.id,
    required this.lugarId,
    required this.nombre,
    required this.cantidadEnLugar,
    required this.cantidadParaLlevar,
  });


  Pertenencia copyWith({
    ValueGetter<int?>? id,
    int? lugarId,
    String? nombre,
    int? cantidadEnLugar,
    int? cantidadParaLlevar,
  }) {
    return Pertenencia(
      id: id != null ? id() : this.id,
      lugarId: lugarId ?? this.lugarId,
      nombre: nombre ?? this.nombre,
      cantidadEnLugar: cantidadEnLugar ?? this.cantidadEnLugar,
      cantidadParaLlevar: cantidadParaLlevar ?? this.cantidadParaLlevar,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lugarId': lugarId,
      'nombre': nombre,
      'cantidadEnLugar': cantidadEnLugar,
      'cantidadParaLlevar': cantidadParaLlevar,
    };
  }

  factory Pertenencia.fromMap(Map<String, dynamic> map) {
    return Pertenencia(
      id: map['id']?.toInt(),
      lugarId: map['lugarId']?.toInt() ?? 0,
      nombre: map['nombre'] ?? '',
      cantidadEnLugar: map['cantidadEnLugar']?.toInt() ?? 0,
      cantidadParaLlevar: map['cantidadParaLlevar']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pertenencia.fromJson(String source) => Pertenencia.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Pertenencia(id: $id, lugarId: $lugarId, nombre: $nombre, cantidadEnLugar: $cantidadEnLugar, cantidadParaLlevar: $cantidadParaLlevar)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      lugarId,
      nombre,
      cantidadEnLugar,
      cantidadParaLlevar,
    ];
  }
}
