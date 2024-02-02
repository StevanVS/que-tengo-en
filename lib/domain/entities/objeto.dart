class Objeto {
  final double id;
  final double lugarId;
  final String nombre;
  final int cantidadEnLugar;
  final int cantidadParaLlevar;

  Objeto({
    required this.id,
    required this.lugarId,
    required this.nombre,
    required this.cantidadEnLugar,
    required this.cantidadParaLlevar,
  });

  static List<Objeto> getObjetos() {
    return [
      Objeto(
        id: 1,
        lugarId: 1,
        nombre: 'Pantalon',
        cantidadEnLugar: 1,
        cantidadParaLlevar: 1,
      ),
      Objeto(
        id: 2,
        lugarId: 1,
        nombre: 'Camiseta formal',
        cantidadEnLugar: 0,
        cantidadParaLlevar: 2,
      ),
      Objeto(
        id: 3,
        lugarId: 1,
        nombre: 'Camiseta sencilla',
        cantidadEnLugar: 2,
        cantidadParaLlevar: 0,
      ),
      Objeto(
        id: 4,
        lugarId: 1,
        nombre: 'Interiores',
        cantidadEnLugar: 1,
        cantidadParaLlevar: 3,
      ),
    ];
  }
}
