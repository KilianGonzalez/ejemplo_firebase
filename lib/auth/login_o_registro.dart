import 'package:ejemplo_firebase/paginas/pagina_login.dart';
import 'package:ejemplo_firebase/paginas/pagina_registro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginORegistro extends StatefulWidget {
  const LoginORegistro({super.key});

  @override
  State<LoginORegistro> createState() => _LoginORegistroState();
}

class _LoginORegistroState extends State<LoginORegistro> {

  bool mostrarpgLogin = true;

  void intercambiarPaginas() {
    setState(() {
      mostrarpgLogin = !mostrarpgLogin;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(mostrarpgLogin) {
      return PaginaLogin(hacerClick: intercambiarPaginas,);
    } else {
      return PaginaRegistro(hacerClick: intercambiarPaginas,);
    }
  }
}