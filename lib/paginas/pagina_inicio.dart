import 'package:ejemplo_firebase/auth/servicio_auth.dart';
import 'package:ejemplo_firebase/chat/servicio_chat.dart';
import 'package:ejemplo_firebase/componentes/item_usuario.dart';
import 'package:ejemplo_firebase/paginas/editar_datos_usuario.dart';
import 'package:ejemplo_firebase/paginas/pagina_chat.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ejemplo_firebase/mongodb/db_conf.dart';

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
        title: Text("Pagina de Inicio"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => const EditarDatosUsuario()
                )
              );
            }, 
            icon: const Icon(Icons.person)
          ),
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

    if(datosUsuario["email"] == ServicioAuth().getUsuarioActual()!.email) {
      
      return Container();
    } 

    return FutureBuilder<Uint8List?>(
    future: DBConf().obtenerImagenPerfil(datosUsuario["uid"]),
    builder: (context, snapshot) {
      Widget icono;

      if (snapshot.connectionState == ConnectionState.waiting) {
        icono = const Icon(Icons.person);
      } else if (snapshot.hasData && snapshot.data != null) {
        icono = Image.memory(
          snapshot.data!,
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        );
      } else {
        icono = const Icon(Icons.person);
      }

      return ListTile(
        leading: icono,
        title: Text(datosUsuario["email"]),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaginaChat(idReceptor: datosUsuario["uid"]),
            ),
          );
        },
      );
    },
  );
  }
}