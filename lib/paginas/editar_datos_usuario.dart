import 'package:ejemplo_firebase/mongodb/db_conf.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongodb;

class EditarDatosUsuario extends StatefulWidget {
  const EditarDatosUsuario({super.key});

  @override
  State<EditarDatosUsuario> createState() => _EditarDatosUsuarioState();
}

class _EditarDatosUsuarioState extends State<EditarDatosUsuario> {

  mongodb.Db? _db;
  Uint8List? _imagenEnBytes;
  final ImagePicker imagePicker = ImagePicker();

  @override
  void dispose() {
    // TODO: implement dispose
    _db?.close(); //si es diferente a null cierra la conexión
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _conectarMongoDB().then((_) => print("Conectados con MongoDB")); //si no queremos usar ningun valor, ponemos un _ para que no de error
  }

  Future _conectarMongoDB() async {
    _db = await mongodb.Db.create(DBConf().connectionString);

    await _db!.open(); //abrir la conexión con mongodb
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        title: Text("Editar datos usuario"),
      ),
      body: const Center(
        child: Column(
          children: [
            Text("Edita tus datos:")
          ],
        ),
      ),
    );
  }
}