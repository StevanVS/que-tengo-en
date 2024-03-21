
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class Lugar extends Equatable {
  final int id;
  final String nombre;
  final bool favorito;
  final DateTime? ultimoEditado;

  const Lugar({
    this.id = -1,
    this.nombre = '',
    this.favorito = false,
    this.ultimoEditado,
  });


  Lugar copyWith({
    int? id,
    String? nombre,
    bool? favorito,
    ValueGetter<DateTime?>? ultimoEditado,
  }) {
    return Lugar(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      favorito: favorito ?? this.favorito,
      ultimoEditado: ultimoEditado != null ? ultimoEditado() : this.ultimoEditado,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'favorito': favorito,
      'ultimoEditado': ultimoEditado?.millisecondsSinceEpoch,
    };
  }

  factory Lugar.fromMap(Map<String, dynamic> map) {
    return Lugar(
      id: map['id']?.toInt() ?? -1,
      nombre: map['nombre'] ?? '',
      favorito: map['favorito'] ?? false,
      ultimoEditado: map['ultimoEditado'] != null ? DateTime.fromMillisecondsSinceEpoch(map['ultimoEditado']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Lugar.fromJson(String source) => Lugar.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Lugar(id: $id, nombre: $nombre, favorito: $favorito, ultimoEditado: $ultimoEditado)';
  }

  @override
  List<Object?> get props => [id, nombre, favorito, ultimoEditado];
}
