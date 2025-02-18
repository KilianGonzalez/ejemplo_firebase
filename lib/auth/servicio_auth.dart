import 'package:firebase_auth/firebase_auth.dart';

class ServicioAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Hacer un registro
  Future<UserCredential> registroConEmailyPassword(String email, password) async {
    try {

      UserCredential credencialUsuario = await _auth.createUserWithEmailAndPassword(
      email: email, 
      password: password
      );

      return credencialUsuario;

    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}