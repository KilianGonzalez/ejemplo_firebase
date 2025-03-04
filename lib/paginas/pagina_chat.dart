import 'package:ejemplo_firebase/chat/servicio_chat.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PaginaChat extends StatefulWidget {

  final String idReceptor;

  const PaginaChat({
    super.key,
    required this.idReceptor,
  });

  @override
  State<PaginaChat> createState() => _PaginaChatState();
}

class _PaginaChatState extends State<PaginaChat> {

  final TextEditingController tecMensaje = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        title: const Text("Sala Chat")
      ),

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
    return Expanded(child: Text("1"));
  }
  
  Widget _crearZonaEscribirMensajes() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(child: 
            TextField(
              controller: tecMensaje,
              decoration: InputDecoration(
                hintText: "Escribe tu mensaje...",
                filled: true,
                fillColor: Colors.teal[50],
              ),
            ),
          ),

          const SizedBox(width: 7),
      
          IconButton(
            onPressed: enviarMensaje, 
            icon: const Icon(Icons.send, color: Colors.indigoAccent),
            style: const ButtonStyle(
              backgroundColor: null,
            ),
          ),
        ],
      ),
    );
  }

  void enviarMensaje() {
    if (tecMensaje.text.isNotEmpty){
      ServicioChat().enviarMensaje(
        widget.idReceptor, 
        tecMensaje.text
      );

      tecMensaje.clear();
    }
  }
}