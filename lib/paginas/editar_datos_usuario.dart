

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejemplo_firebase/auth/servicio_auth.dart';
import 'package:ejemplo_firebase/mongodb/db_conf.dart';
import 'package:ejemplo_firebase/paginas/pagina_inicio.dart';
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
    cargarNombreUsuario();
  }

  void cargarNombreUsuario() async {
    try {
      String? nombre = await ServicioAuth().nombreUsuarioActual();
      setState(() {
        nombreUsuario.text = nombre ?? "";
      });
    } catch (e) {
      print("Error cargando el nombre: $e");
    }
  }


  Future _conectarMongoDB() async {
    _db = await mongodb.Db.create(DBConf().connectionString);

    await _db!.open(); //abrir la conexión con mongodb
  }

  final TextEditingController nombreUsuario = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        title: const Text("Editar datos usuario"),
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Edita tus datos:"),

            //Añadimos la imagen o un texto
            _imagenEnBytes != null ? Image.memory(_imagenEnBytes!, height: 200,) : const Text("No se ha seleccionado ninguna imagen"),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                _subirImagen();
              }, 
              child: const Text("Subir imagen")
            ),

            ElevatedButton(
              onPressed: () {
                _recuperarImagen();
              }, 
              child: const Text("Recuperar imagen")
            ),

            const SizedBox(height: 20),

            Text("---------------------------------------------------------------------------------------------------------",
              style: TextStyle(
                color: Colors.pink[300],
              ),
            ),

            const SizedBox(height: 12),

            Text(ServicioAuth().getUsuarioActual()!.email!, 
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            TextField(
              controller: nombreUsuario,
              decoration: const InputDecoration(
                hintText: "Escribe tu nombre...",
              ),
            ),

            ElevatedButton(
              onPressed: () {
                guardarNombreUsuario();
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.pink[300]),
              ),
              child: const Text("Guardar"),
            )
          ],
        ),
      ),
    );
  }

  Future <void> _cargarNombre() async {
    final nombreUsuario = ServicioAuth().getUsuarioActual();

    if (nombreUsuario == null) {
      return;
    }
  }

  void guardarNombreUsuario() async {
  final nuevoNombre = nombreUsuario.text;

  if (nuevoNombre.isEmpty) {
    return;
  }

  try {
    final user = ServicioAuth().getUsuarioActual();
    if (user == null) return;

    final firestore = FirebaseFirestore.instance;
    final querySnapshot = await firestore.collection("Usuarios").where("email", isEqualTo: user.email).limit(1).get();

    if (querySnapshot.docs.isNotEmpty) {
      final docId = querySnapshot.docs.first.id;
      await firestore.collection("Usuarios").doc(docId).update({
        "nombre": nuevoNombre,
      });

      Navigator.pop(
        context
      );

      print("Nombre actualizado correctamente");
    } else {
      print("Usuario no encontrado");
    }
  } catch (e) {
    print("Error al guardar el nombre: $e");
  }
}


  Future _subirImagen() async {

    final imagenseleccionada = await imagePicker.pickImage(source: ImageSource.gallery);

    //Comprobar si ha encontrado una imagen
    if (imagenseleccionada != null) {

      //Pasamos la imagen a bytes para poder guardarla
      final bytesImagen = await File(imagenseleccionada.path).readAsBytes();

      //Pasamos los bytes al formato que a MongoDB le va bien
      final datosBinarios = mongodb.BsonBinary.from(bytesImagen);

      //Nos situamos en esta colección, si no está creada, se creará automaticamente
      final collection = _db!.collection("imagenes_perfiles");

      await collection.replaceOne(
        {
          "id_usuario_firebase": ServicioAuth().getUsuarioActual()!.uid
        }
        ,
        {
          "id_usuario_firebase": ServicioAuth().getUsuarioActual()!.uid,
          "nombre_foto": "foto_perfil",
          "imagen": datosBinarios,
          "fecha_subida": DateTime.now()
        },
        //Si no encuentra el documento, lo crea
        upsert: true
      );
      print("Imagen puesta");
    }
  }

  Future <void> _recuperarImagen() async {

    try {
      //Nos conectamos con la collection que queremos
      final collection = _db!.collection("imagenes_perfiles");

      //Buscar el documento deseado
      final doc = await collection.findOne({"id_usuario_firebase": ServicioAuth().getUsuarioActual()!.uid});

      //Hay que cambiar el formato de Bson a MongoDB
      if (doc != null && doc["imagen"] != null) {
        final imagenBson = doc ["imagen"] as mongodb.BsonBinary;
        setState(() {
          _imagenEnBytes = imagenBson.byteList;
        });
      } else {
        print("Error encontrando la imagen en el documento");
      }
    } catch (e) {
        print("Error intentando recuperar el documento");
    }
  }
}