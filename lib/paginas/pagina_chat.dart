import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejemplo_firebase/auth/servicio_auth.dart';
import 'package:ejemplo_firebase/chat/servicio_chat.dart';
import 'package:ejemplo_firebase/componentes/burbuja_mensaje.dart';
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
  final ScrollController scControlador = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {
        hacerScrollAbajo();
    });
  }

  void hacerScrollAbajo() {
    scControlador.animateTo(
      scControlador.position.maxScrollExtent + 100, 
      duration: const Duration(seconds: 1), 
      curve: Curves.fastOutSlowIn
    );
  }

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
    return Expanded(
      child: StreamBuilder(
        stream: ServicioChat().getMensajes(ServicioAuth().getUsuarioActual()!.uid, widget.idReceptor), 
        builder: (context, snapshot){

          //caso de error
          if(snapshot.hasError) {
            return const Text("Error en el snapshot");
          }

          //caso de tiempo de carga de datos
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Cargando mensajes...");
          }

          //devolver mensajes
          return ListView(
            controller: scControlador,
            children: snapshot.data!.docs.map((document) => _construirItemMensaje(document)).toList(),
          );
        },
      ),
    );
  }

  Widget _construirItemMensaje(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    return BurbujaMensaje(
      mensaje: data["mensaje"], 
      idAutor: data["idAutor"]
    );
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

      Future.delayed(const Duration(milliseconds: 50), () {
        hacerScrollAbajo();
      });
    }
  }
}