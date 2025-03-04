
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejemplo_firebase/modelos/mensaje.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServicioChat {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUsuarios() {

    return _firestore.collection("Usuarios").snapshots().map((event) {

      return event.docs.map((document) {

        return document.data();
        
      }).toList();
    });
  }

  Future<void> enviarMensaje(String idReceptor, String mensaje) async {

    // La sala de chat es entre dos usuarios. La creamos a partir de sus uid's.

    String idUsuarioActual = _auth.currentUser!.uid; //Obtenemos el uid del usuario actual, que es el que enviará el mensaje.
    String emailUsuarioActual = _auth.currentUser!.email!;
    Timestamp timestamp = Timestamp.now(); // Momento en el que se envia el mensaje.

    Mensaje nuevoMensaje = Mensaje(
      idAutor: idUsuarioActual, 
      emailAutor: emailUsuarioActual, 
      idReceptor: idReceptor, 
      mensaje: mensaje, 
      timestamp: timestamp
    );

    List<String> idsUsuarios = [idUsuarioActual, idReceptor];
    idsUsuarios.sort(); // Ordenamos la lista alfabeticamente (asi siempre es igual), independientemente del usuario que tenga la sesión abierta.

    String idSalaChat = idsUsuarios.join("_");

    await _firestore.collection("SalasChat").doc(idSalaChat).collection("Mensajes").add(nuevoMensaje.retornarMapaMensaje());
  }
}