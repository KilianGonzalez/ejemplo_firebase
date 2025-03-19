import 'package:ejemplo_firebase/auth/portal_auth.dart';
import 'package:ejemplo_firebase/firebase_options.dart';
import 'package:ejemplo_firebase/paginas/pagina_login.dart';
import 'package:ejemplo_firebase/paginas/pagina_registro.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      print("Error iniciando Firebase");
    }
  } else {
    print("Error, Firebase ya esta iniciado");
  }
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PortalAuth(),
    );
  }
}
