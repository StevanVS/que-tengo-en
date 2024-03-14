class Lugar {
  final int id;
  final String nombre;
  final bool favorito;

  Lugar({
    required this.id,
    required this.nombre,
    this.favorito = false,
  });

  static List<Lugar> getLugares() {
    return [
      Lugar(id: 1, nombre: 'Portoviejo', favorito: true),
      Lugar(id: 2, nombre: 'Manta', favorito: false),
    ];
  }
}
