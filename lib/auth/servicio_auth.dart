import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServicioAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Usuario actual
  User? getUsuarioActual() {
    return _auth.currentUser;
  }

  //Hacer logout
  Future<void> logout() async {
    
    return await _auth.signOut();
  }

  //Hacer login
  Future<String?> loginConEmailyPassword(String email, String password) async {
    try {

      UserCredential credencialUsuario = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );

      return null;

    } on FirebaseAuthException catch (e) {
      return "Error ${e.message}";
    }
  }


  //Hacer un registro
  Future<String?> registroConEmailyPassword(String email, password) async {
    try {

      UserCredential credencialUsuario = await _auth.createUserWithEmailAndPassword(
      email: email, 
      password: password,
      );

      _firestore.collection("Usuarios").doc(credencialUsuario.user!.uid).set({
        "uid": credencialUsuario.user!.uid,
        "email": email,
        "nombre": "",
      });

      return null;

    } on FirebaseAuthException catch (e) {
      
      switch(e.code){
        case "email-already-in-use":
          return "Ya existe un usuario con este email.";

        case "invalid-email":
          return "Email no válido.";

        case "operation-not-allowed":
          return "Email y/o contraseña no habilitados.";

        case "weak-password":
          return "Introduzca una contraseña más robusta.";

        default:
          return "Error: ${e.message}";
      }
    } catch (e) {
      return "Error ${e}";
    }
  }
}