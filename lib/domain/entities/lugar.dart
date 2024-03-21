import 'dart:convert';

import 'package:flutter/widgets.dart';

class Lugar {
  final int? id;
  final String nombre;
  final bool favorito;
  final DateTime? ultimoEditado;

  Lugar({
    this.id,
    this.nombre = '',
    this.favorito = false,
    this.ultimoEditado,
  });

  static List<Lugar> getLugares() {
    return [
      Lugar(id: 1, nombre: 'Portoviejo', favorito: true),
      Lugar(id: 2, nombre: 'Manta', favorito: false),
    ];
  }

  Lugar copyWith({
    ValueGetter<int?>? id,
    String? nombre,
    bool? favorito,
    ValueGetter<DateTime?>? ultimoEditado,
  }) {
    return Lugar(
      id: id != null ? id() : this.id,
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
      id: map['id']?.toInt(),
      nombre: map['nombre'] ?? '',
      favorito: map['favorito'] ?? false,
      ultimoEditado: map['ultimoEditado'] != null ? DateTime.fromMillisecondsSinceEpoch(map['ultimoEditado']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Lugar.fromJson(String source) => Lugar.fromMap(json.decode(source));
}
