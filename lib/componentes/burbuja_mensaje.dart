import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BurbujaMensaje extends StatelessWidget {

  final String mensaje;

  const BurbujaMensaje({
    super.key,
    required this.mensaje,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
      child: Container(
        color: Colors.pink[400],
        child: Text(mensaje),
      ),
    );
  }
}