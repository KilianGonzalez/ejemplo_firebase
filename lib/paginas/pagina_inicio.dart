import 'package:ejemplo_firebase/auth/servicio_auth.dart';
import 'package:ejemplo_firebase/chat/servicio_chat.dart';
import 'package:ejemplo_firebase/componentes/item_usuario.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PaginaInicio extends StatefulWidget {
  const PaginaInicio({super.key});

  @override
  State<PaginaInicio> createState() => _PaginaInicioState();
}

class _PaginaInicioState extends State<PaginaInicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        title: const Text("Página de inicio"),
        actions: [
          IconButton(
            onPressed: () {
              ServicioAuth().logout();
            }, 
            icon: Icon(Icons.logout)
          ),
        ],
      ),
      body: StreamBuilder(
        stream: ServicioChat().getUsuarios(), 
        builder: (context, snapshot) {
          
          // Caso de que haya error
          if(snapshot.hasError) {
            return const Text("Error en el snapshot");
          }

          if(snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Cargando datos...");
          }

          //Se devuelven los datos
          return ListView(
            children: snapshot.data!.map<Widget> (
              (datosUsuario) => _construirItemUsuario(datosUsuario)
            ).toList(),
          );
        },
      ),
    );
  }

  Widget _construirItemUsuario(Map<String, dynamic> datosUsuario) {

    return ItemUsuario(
      emailUsuario: datosUsuario["email"]
    );
  }
}