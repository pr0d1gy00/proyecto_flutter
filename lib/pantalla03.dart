import 'dart:convert';
import 'dart:io';
import 'package:app_productos/pantalla02.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './drawer.dart';

class Pantalla03 extends StatefulWidget {
  final String? nombre;
  final String? codigo;
  final String? descripcion;
  final double? cantidad;
  final double? stockmax;
  final double? stockmin;
  final double? precio;
  final String? codcat;
  final String? apiIp;
  const Pantalla03(
      {super.key,
      required this.nombre,
      required this.codigo,
      required this.descripcion,
      required this.cantidad,
      required this.stockmax,
      required this.stockmin,
      required this.precio,
      required this.codcat,
      required this.apiIp});

  @override
  State<Pantalla03> createState() => _Pantalla03State();
}

class _Pantalla03State extends State<Pantalla03> {
  TextEditingController controllerNombre = TextEditingController();
  TextEditingController controllerCodigo = TextEditingController();
  TextEditingController controllerDescripcion = TextEditingController();
  TextEditingController controllerCantidad = TextEditingController();
  TextEditingController controllerStockmax = TextEditingController();
  TextEditingController controllerStockmin = TextEditingController();
  TextEditingController controllerPrecio = TextEditingController();
  TextEditingController controllerCodcat = TextEditingController();
  String? apiIp;

  @override
  void initState() {
    // Valor inicial
    super.initState();
    controllerNombre.text = widget.nombre ?? '';
    controllerCodigo.text = widget.codigo ?? '';
    controllerDescripcion.text = widget.descripcion ?? '';
    controllerCantidad.text = widget.cantidad?.toString() ?? '';
    controllerStockmax.text = widget.stockmax?.toString() ?? '';
    controllerStockmin.text = widget.stockmin?.toString() ?? '';
    controllerPrecio.text = widget.precio?.toString() ?? '';
    controllerCodcat.text = widget.codcat ?? '';
    apiIp = widget.apiIp;
  }

  // Removed duplicate build method
  Future<int> updateProduct(String productId, Product producto) async {
    if (apiIp == null) {
      throw Exception('IP address is invalid');
    }
    final url = Uri.parse(
        'http://$apiIp:8080/api/v1/products?codigo=${producto.codigo}');
    final response = await http.patch(url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: postToJson(producto));

    if (response.statusCode == 200) {
      return Future.value(1);
    } else {
      throw Exception(
          'Error al actualizar el producto: ${response.statusCode}');
    }
  }

  String postToJson(Product producto) {
    final Map<String, dynamic> data = {
      'name': producto.nombre,
      'code': producto.codigo,
      'description': producto.descripcion,
      'quantity': producto.cantidad,
      'stockMax': producto.stockmax,
      'stockMin': producto.stockmin,
      'price': producto.precio,
      'categoryCode': producto.codcat,
    };
    return json.encode(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            drawer: const MenuLateral(),
    appBar: AppBar(
            title: const Text('Lista'),
          ),
      body: ListView(

        padding: const EdgeInsets.all(10),
        children: <Widget>[
          Row(
            children: [
              const Text('CODIGO'),
              const SizedBox(width: 5),
              Expanded(
                child: TextField(
                  controller: controllerCodigo,
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
          const SizedBox(height: 10),
          Row(
            children: [
              const Text('NOMBRE'),
              const SizedBox(width: 5),
              Expanded(
                child: TextField(
                  controller: controllerNombre,
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
          const SizedBox(height: 10),
          Row(
            children: [
              const Text('DESCRIPCIÓN'),
              const SizedBox(width: 5),
              Expanded(
                child: TextField(
                  controller: controllerDescripcion,
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
          const SizedBox(height: 10),
          Row(
            children: [
              const Text('CANTIDAD'),
              const SizedBox(width: 5),
              Expanded(
                child: TextField(
                  controller: controllerCantidad,
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
          const SizedBox(height: 10),
          Row(
            children: [
              const Text('STOCK MÁXIMO'),
              const SizedBox(width: 5),
              Expanded(
                child: TextField(
                  controller: controllerStockmax,
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
          const SizedBox(height: 10),
          Row(
            children: [
              const Text('STOCK MÍNIMO'),
              const SizedBox(width: 5),
              Expanded(
                child: TextField(
                  controller: controllerStockmin,
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
          const SizedBox(height: 10),
          Row(
            children: [
              const Text('PRECIO'),
              const SizedBox(width: 5),
              Expanded(
                child: TextField(
                  controller: controllerPrecio,
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
          const SizedBox(height: 10),
          Row(
            children: [
              const Text('CÓDIGO CATEGORÍA'),
              const SizedBox(width: 5),
              Expanded(
                child: TextField(
                  controller: controllerCodcat,
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
          ElevatedButton(
              onPressed: () async {
                final producto = Product(
                  nombre: controllerNombre.text,
                  codigo: controllerCodigo.text,
                  descripcion: controllerDescripcion.text,
                  cantidad: double.parse(controllerCantidad.text),
                  stockmax: double.parse(controllerStockmax.text),
                  stockmin: double.parse(controllerStockmin.text),
                  precio: double.parse(controllerPrecio.text),
                  codcat: controllerCodcat.text,
                );

                try {
                  await updateProduct(producto.codigo, producto);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Producto actualizado con éxito')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Error al actualizar el producto: $e')),
                  );
                }
              },
              child: Text('Actualizar'))
        ],
      ),
    );
  }
}
