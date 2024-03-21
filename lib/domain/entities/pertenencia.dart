import 'dart:convert';

import 'package:equatable/equatable.dart';

class Pertenencia extends Equatable {
  final int id;
  final int lugarId;
  final String nombre;
  final int cantidadEnLugar;
  final int cantidadParaLlevar;

  const Pertenencia({
    this.id = -1,
    this.lugarId = -1,
    this.nombre = '',
    this.cantidadEnLugar = 0,
    this.cantidadParaLlevar = 0,
  });


  Pertenencia copyWith({
    int? id,
    int? lugarId,
    String? nombre,
    int? cantidadEnLugar,
    int? cantidadParaLlevar,
  }) {
    return Pertenencia(
      id: id ?? this.id,
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
      id: map['id']?.toInt() ?? -1,
      lugarId: map['lugarId']?.toInt() ?? -1,
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
  List<Object> get props {
    return [
      id,
      lugarId,
      nombre,
      cantidadEnLugar,
      cantidadParaLlevar,
    ];
  }
}
