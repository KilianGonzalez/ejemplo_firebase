import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejemplo_firebase/auth/servicio_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BurbujaMensaje extends StatelessWidget {

  final String mensaje;
  final String idAutor;
  final Timestamp horaMensaje;

  const BurbujaMensaje({
    super.key,
    required this.mensaje,
    required this.idAutor,
    required this.horaMensaje,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
      child: Align(
        alignment: idAutor == ServicioAuth().getUsuarioActual()!.uid ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: idAutor == ServicioAuth().getUsuarioActual()!.uid ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: idAutor == ServicioAuth().getUsuarioActual()!.uid ? Colors.deepPurple[400] : Colors.pink[400],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(mensaje),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 3, right: 3),
              child: _formatearTiempo(),
            )
          ],
        ),
        
      ),
    );
  }

  Widget _formatearTiempo() {
    final DateTime fechaMensaje = horaMensaje.toDate().toLocal();
    final DateTime ahora = DateTime.now();
    final Duration diferencia = ahora.difference(fechaMensaje);

    if (diferencia.inDays >= 2) {
      return Text("Hace ${diferencia.inDays} dias",
        style: TextStyle(
          color: idAutor == ServicioAuth().getUsuarioActual()!.uid ? Colors.deepPurple[400] : Colors.pink[400],
          fontSize: 10,
          fontWeight: FontWeight.bold
        ),
      );
    } else if (diferencia.inDays == 1) {
      return Text("Hace 1 dia",
        style: TextStyle(
          color: idAutor == ServicioAuth().getUsuarioActual()!.uid ? Colors.deepPurple[400] : Colors.pink[400],
          fontSize: 10,
          fontWeight: FontWeight.bold
        ),
      );
    } else {
      return Text("${fechaMensaje.hour.toString().padLeft(2, '0')}:"
           "${fechaMensaje.minute.toString().padLeft(2, '0')}",
           style: TextStyle(
            color: idAutor == ServicioAuth().getUsuarioActual()!.uid ? Colors.deepPurple[400] : Colors.pink[400],
            fontSize: 10,
            fontWeight: FontWeight.bold
          ),
      );
    }
  }
}