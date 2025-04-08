import 'dart:typed_data';
import 'package:mongo_dart/mongo_dart.dart' as mongodb;

class DBConf{
  String connectionString = "mongodb+srv://kiliangonzalez:Kilito07072005@cluster0.lqj3b.mongodb.net/flutter_imagenes?retryWrites=true&w=majority&appName=Cluster0";

  Future<Uint8List?> obtenerImagenPerfil(String uid) async {
    try {
      // Conectar a la base de datos
      final db = await mongodb.Db.create(connectionString);
      await db.open();
      final collection = db.collection('imagenes_perfiles'); // La colección de las imágenes de perfil

      // Buscar el documento que contiene la imagen de perfil del usuario
      final doc = await collection.findOne({'id_usuario_firebase': uid});
      await db.close();

      if (doc != null && doc['imagen'] != null) {
        // Convertir la imagen de BSON Binary a Uint8List
        final imagenBson = doc['imagen'] as mongodb.BsonBinary;
        return imagenBson.byteList; // Retorna los bytes de la imagen
      } else {
        return null; // Si no hay imagen, retorna null
      }
    } catch (e) {
      print("Error al obtener la imagen de perfil: $e");
      return null; // Si hay un error, retorna null
    }
  }
}