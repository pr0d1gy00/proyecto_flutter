import 'dart:convert';

List<Producto> carsModelFromJson(String str) => List<Producto>.from(json.decode(str).map((x) => Producto.fromJson(x)));

String carsModelToJson(List<Producto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Producto{
  
  Producto({
    required this.codigo,
    required this.nombre,
    required this.descripcion,
    required this.cantidad,
    required this.stockmax,
    required this.stockmin,
    required this.precio,
    required this.codcat
    });

  final int codigo;
  final String nombre;
  final String descripcion;
  final int cantidad;
  final int stockmax;
  final int? stockmin;
  final double? precio;
  final String? codcat;

    factory Producto.fromJson(Map<String, dynamic> json) => Producto(
    codigo: json["codigo"],
    nombre: json["nombre"],
    descripcion: json["descripcion"],
    cantidad: json["cantidad"],
    stockmax: json["stockmax"],
    stockmin: json["stockmin"],
    precio: json["precio"],
    codcat: json["codcat"],
  );

  Map<String, dynamic> toJson() => {
    "codigo": codigo,
    "nombre": nombre,
    "descripcion": descripcion,
    "cantidad": cantidad,
    "stockmax": stockmax,
    "stockmin": stockmin,
    "precio": precio,
    "codcat": codcat,
  };

}
