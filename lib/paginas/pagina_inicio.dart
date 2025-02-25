import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PaginaInicio extends StatelessWidget {
  const PaginaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Página de inicio"),
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.logout)
          ),
        ],
      ),
      body: const Text("Página de inicio"),
    );
  }
}