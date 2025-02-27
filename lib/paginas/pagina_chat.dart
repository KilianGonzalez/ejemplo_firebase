import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PaginaChat extends StatefulWidget {
  const PaginaChat({super.key});

  @override
  State<PaginaChat> createState() => _PaginaChatState();
}

class _PaginaChatState extends State<PaginaChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [

          //Zona mensajes
          _crearZonaMostrarMensajes(),

          //Zona escribir mensajes
          _crearZonaEscribirMensajes(),
        ],
      ),
    );
  }
  
  Widget _crearZonaMostrarMensajes() {
    return Text("1");
  }
  
  Widget _crearZonaEscribirMensajes() {
    return Text("2");
  }
}