import 'package:flutter/material.dart';
import 'pantalla03.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'drawer.dart';
import 'dart:io';

class Product {
  final String codigo;
  final String nombre;
  final String descripcion;
  final double cantidad;
  final double stockmax;
  final double stockmin; // error
  final double precio;
  final String codcat;

  Product({
    required this.codigo,
    required this.nombre,
    required this.descripcion,
    required this.cantidad,
    required this.stockmax,
    required this.stockmin,
    required this.precio,
    required this.codcat,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      codigo: json['codigo'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      cantidad: json['cantidad'].toDouble(),
      stockmax: json['stockmax'].toDouble(),
      stockmin: json['stockmin'].toDouble(),
      precio: json['precio'].toDouble(),
      codcat: json['codcat'],
    );
  }
}

class Pantalla02 extends StatefulWidget {
  final String? ipAdress;
  const Pantalla02({super.key, required this.ipAdress});
  @override
  State<Pantalla02> createState() => _Pantalla02State();
}

class _Pantalla02State extends State<Pantalla02> {
  TextEditingController controllerIp = TextEditingController();
  Future<List<Product>>? _productList;
  var apiIp;
  var conexion;
var _connectionStatus = "";
  @override
  void initState() {
    // Valor inicial
    super.initState();
    controllerIp.text = '';
    apiIp = widget.ipAdress;
    _productList = fetchData();
  }

  Future<List<Product>> fetchData() async {
if (apiIp == null) {
      throw Exception('IP address is invalid');
    }
    try {
      final response = await http.get(Uri.parse('http://$apiIp:8080/api/v1/products'));
      if (response.statusCode == 200) {
        setState(() {
          _connectionStatus = "conexión OK";
          controllerIp.text = _connectionStatus;
        });
        final data = jsonDecode(response.body) as List<dynamic>;
        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Error al obtener la informacion (Status Code: ${response.statusCode})');
      }
    } on SocketException catch (e) {
      setState(() {
        _connectionStatus = "conexión rechazada";
        controllerIp.text = _connectionStatus;
      });
      return Future.error(Exception('Conexion rechazada: ${e.address}'));
    } catch (e) {
      setState(() {
        _connectionStatus = "Error desconocido";
        controllerIp.text = _connectionStatus;
      });
      return Future.error(Exception('Error: $e'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuLateral(),
      appBar: AppBar(
        title: const Text('Lista'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fondo.jpeg"),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            Row(children: [
              const Text('API:'),
              const SizedBox(width: 5),
              Expanded(
                child: TextField(
                  controller: controllerIp,
                  readOnly: true,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    //border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 20,
            ),
            const Text('Datos', textAlign: TextAlign.center),
            FutureBuilder<List<Product>>(
              future: _productList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return Container(
                      height: 430,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final product = snapshot.data![index];
                          return ListTile(
                            title: Text('* ${product.codigo}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Divider(),
                                Text('Codigo: ${product.codigo}'),
                                const Divider(),
                                Text('Nombre: ${product.nombre}'),
                                const Divider(),
                                Text('Descripcion: ${product.descripcion}'),
                                const Divider(),
                                Text('Cantidad: ${product.cantidad}'),
                                const Divider(),
                                Text('Stock máximo: ${product.stockmax}'),
                                const Divider(),
                                Text('Stock mínimo: ${product.stockmin}'),
                                const Divider(),
                                Text('Precio: ${product.precio}'),
                                const Divider(),
                                Text(
                                    'Código de categoría: ${product.codcat}'),
                                const Divider(),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Pantalla03(
                                      codigo:product.codigo,
                                      nombre: product.nombre,
                                      descripcion:product.descripcion,
                                      cantidad: product.cantidad,
                                      stockmax:product.stockmax,
                                      stockmin:product.stockmin,
                                      precio:product.precio,
                                      codcat:product.codcat,
                                      apiIp: apiIp
                                    ),
                                  ));
                              },
                            ),
                            textColor: const Color.fromARGB(255, 0, 0, 0),
                            contentPadding: const EdgeInsets.all(5),
                          );
                        },
                      ));
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Regresar')),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                },
                child: const Text('Inicio')),
          ],
        ),
      ),
    );
  }
}
