import 'package:flutter/material.dart';

class Pantalla03 extends StatefulWidget {
  final String? nombre;
  final String? codigo;
  final String? descripcion;
  final double? cantidad;
  final double? stockmax;
  final double? stockmin;
  final double? precio;
  final String? codcat;
  const Pantalla03(
      {super.key,
      required this.nombre,
      required this.codigo,
      required this.descripcion,
      required this.cantidad,
      required this.stockmax,
      required this.stockmin,
      required this.precio,
      required this.codcat});
  @override
  State<Pantalla03> createState() => _Pantalla03State();
}

final TextEditingController nombre = TextEditingController();

class _Pantalla03State extends State<Pantalla03> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: <Widget>[
          Row(
            children: [
              const Text('CODIGO'),
              const SizedBox(width: 5),
              Expanded(
                child: TextField(
                  controller:nombre ,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ]
      ),
    );
  }
}
