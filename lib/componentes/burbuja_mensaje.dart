import 'package:ejemplo_firebase/auth/servicio_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BurbujaMensaje extends StatelessWidget {

  final String mensaje;
  final String idAutor;

  const BurbujaMensaje({
    super.key,
    required this.mensaje,
    required this.idAutor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
      child: Align(
        alignment: idAutor == ServicioAuth().getUsuarioActual()!.uid ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: idAutor == ServicioAuth().getUsuarioActual()!.uid ? Colors.deepPurple[400] : Colors.pink[400],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(mensaje),
          ),
        ),
      ),
    );
  }
}