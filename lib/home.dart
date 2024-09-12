// usar < flutter pub get > para cargar los paquetes
import 'package:flutter/material.dart';
import './pantalla01.dart';
import 'drawer.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Electiva I',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            // ignore: prefer_const_constructors
            seedColor: Color.fromARGB(255, 0, 193, 241)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Formulario de Captura de datos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _HomeState();
}

class _HomeState extends State<MyHomePage> {
  //variables
  
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    // Formatea la fecha y hora
    return Scaffold(
      drawer: const MenuLateral(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        title: const Text('Navegacion entre Pantallas'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Bienvenidos al actualizar de sus productos',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                    now.toString()
                ),
                const Text(
                  'Integrantes : Carlos mendoza, '
                  'Joselyn Aponte, '
                  'Angel Rodriguez, '
                  'Moises Reyes, '
                  'Mauricio Alvarez, '
                  'Daniela Sivira, '
                  
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Pantalla01()));
                    },
                    child: const Text('Entrar')),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Pantalla01()));*/
                    },
                    child: const Text('Salir')),
              ]),
        ],
      ),
    );
  }
}
