
import 'package:cloud_firestore/cloud_firestore.dart';

class Mensaje {

  final String idAutor;
  final String emailAutor;
  final String idReceptor;
  final String mensaje;
  final Timestamp timestamp;

  Mensaje({
    required this.idAutor,
    required this.emailAutor,
    required this.idReceptor,
    required this.mensaje,
    required this.timestamp
  });

  Map<String, dynamic> retornarMapaMensaje() {

    return {
      "idAutor": idAutor,
      "emailAutor": emailAutor,
      "idReceptor": idReceptor,
      "mensaje": mensaje,
      "timestamp": timestamp
    };
  }
}