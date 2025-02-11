import 'package:ejemplo_firebase/componentes/boton_auth.dart';
import 'package:ejemplo_firebase/componentes/text_field_auth.dart';
import 'package:flutter/material.dart';

class PaginaRegistro extends StatelessWidget {
  const PaginaRegistro({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController tecEmail = TextEditingController();
    final TextEditingController tecPassword = TextEditingController();
    final TextEditingController tecConfPass = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.orange[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            
                //Logo
                Icon(
                  Icons.fireplace, 
                  size: 120, 
                  color: Colors.pink[300]
                ),
            
                const SizedBox(
                  height: 25,
                ),
            
                //Frase
                Text(
                  "Crea una cuenta nueva!",
                  style: TextStyle(
                    color: Colors.pink[300],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            
                const SizedBox(
                  height: 25,
                ),
          
                //Texto divisorio
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.pink[300],
                        ),
                      ),
                  
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          "Registrate",
                          style: TextStyle(
                            color: Colors.pink[300],
                          ),
                        ),
                      ),
                  
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.pink[300],
                        ),
                      ),
                    ],
                  ),
                ),
          
                //TextField Email
                TextFieldAuth(
                  controller: tecEmail,
                  obscureText: true,
                  hintText: "Introduce tu Email...",
                ),
            
                //TextField Password
                TextFieldAuth(
                  controller: tecPassword,
                  obscureText: true,
                  hintText: "Introduce tu contraseña",
                ),
            
                //TextField confirmar Password
                TextFieldAuth(
                  controller: tecConfPass,
                  obscureText: true,
                  hintText: "Confirma la contraseña",
                ),
          
                const SizedBox(
                  height: 10,
                ),
            
                //No estás registrado/a?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Ya eres miembro?",
                      style: TextStyle(
                        color: Color.fromARGB(255, 222, 100, 0),
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      child: Text(
                        "Inicia sesión",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.pink[300],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
            
                //Botón registrate
                BotonAuth(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}