import 'package:ejemplo_firebase/auth/servicio_auth.dart';
import 'package:ejemplo_firebase/componentes/boton_auth.dart';
import 'package:ejemplo_firebase/componentes/text_field_auth.dart';
import 'package:flutter/material.dart';

class PaginaRegistro extends StatelessWidget {

  final Function()? hacerClick;

  const PaginaRegistro({
    super.key,
    required this.hacerClick,
  });

  void Registro(BuildContext context, String email, String password, String confPassword) async {

    if(password.isEmpty || email.isEmpty){
      return;
    }

    if(password != confPassword){
      return;
    }

    String? error = await ServicioAuth().registroConEmailyPassword(email, password);

    if(error != null) {
      showDialog(context: context, builder: (context) => AlertDialog(
        backgroundColor: Color.fromARGB(255, 250, 183, 159),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: const Text("Error"),
        content: Text("Email y/o contraseña incorrectos"),
      ));
    }
  }

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
                  obscureText: false,
                  hintText: "Introduce tu email...",
                ),
            
                //TextField Password
                TextFieldAuth(
                  controller: tecPassword,
                  obscureText: true,
                  hintText: "Introduce tu contraseña... (6 caracteres min.)",
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
                      onTap: hacerClick,
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
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: BotonAuth(
                    texto: "Registrarse",
                    onTap: () => Registro(
                      context, 
                      tecEmail.text, 
                      tecPassword.text, 
                      tecConfPass.text
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}