import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final List<String> filtros = [
  'Lavandería',
  'Pizzería',
  'Supermecado',
  'Droguería',
  'Ferretería',
  'Cafeteria',
  'Panadería',
];

final List<String> nombreLocal = [
  'La Heladeria de mi barrio',
  'Panaderia Pasteleria Din Don Pan'
];

final List<String> direccionLocal = [
  'Direccion: KR 7A # 10 - 82 Sur',
  'Cl. 27 Sur #5-39'
];

final List<String> telefonoLocal = [
  'Telefono: 3019814567',
  '3112122133'
];

final List<String> imagenLocal = [
  'img/heladeria.jpg',
  'img/dindonpan.jpg'
];

int colorAppBar = 0xffff5722;
int colorBody = 0xffffffff;
int colorBox = 0xffff5722;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
      MaterialApp(
        home: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Pantalla Principal
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(colorAppBar),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.account_circle_rounded),
              onPressed: () => print('Presiono el User'),
            );
          },
        ),
        title: Center(
          child: Text('VECI'),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => busqueda()),
                );
              }
          ),
        ],
      ),
      backgroundColor: Color(colorBody),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 25, top: 25, right: 25, bottom: 0),
              child: Center(
                child: Container(
                  width: 200,
                  height: 200,
                  child: Image.asset('img/logo2.png'),
                ),
              ),
            ),

            locales(),
          ],
        ),
      ),
    );
  }
}
//Pantalla de Busqueda
class busqueda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(colorAppBar),
        title: Text('Modulo de busqueda'),
      ),
      backgroundColor: Color(colorBody),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 25, top: 25, right: 25, bottom: 0),
              child: Container(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Producto a buscar',
                    hintText: 'Por favor ingrese el producto a buscar',
                  ),
                ),
              ),
            ),

            Padding(padding: EdgeInsets.only(left: 25, top: 25, right: 25, bottom: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      'Filtros',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 300.0,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: filtros.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return listadoFiltros(filtros[index]);
                },
              ),
            ),

            Padding(padding: EdgeInsets.only(top: 10),
              child: MaterialButton(
                  onPressed: () {
                    print('Presione el boton');
                  },
                  color: Color(colorBox),
                  textColor: Colors.white,
                  child: Text('Buscar')
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//CheckLists en Pantalla de Busqueda
class listadoFiltros extends StatefulWidget {
  //const listadoFiltros({Key? key}) : super(key: key);

  String palabra;

  listadoFiltros(this.palabra);

  @override
  State<listadoFiltros> createState() => filtro(palabra);
}
class filtro extends State<listadoFiltros> {

  String dato;

  filtro(this.dato);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(dato),
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Color(colorBox),
      value: timeDilation != 0.1,
      onChanged: (bool? value) {
        setState(() {
          timeDilation = value! ? 0.2 : 0.1;
        });
      },
    );
  }
}
//Listado de locales en Pantalla Principal
class locales extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: nombreLocal.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.only(left: 15, top: 5, right: 15, bottom: 5),
            elevation: 3,
            child: MaterialButton(
              onPressed: () {print('Presiono la carta');},
              child: Column(
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      title: Text(nombreLocal[index]),
                      subtitle: Text('${direccionLocal[index]}\n${telefonoLocal[index]}'),
                      leading: Image.asset(imagenLocal[index]),
                    ),
                  ]
              ),
            ),
          );
        },
      ),
    );
  }
}