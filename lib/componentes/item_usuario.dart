import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ItemUsuario extends StatelessWidget {
  final String emailUsuario;
  final Function() onTap;

  const ItemUsuario({
    super.key,
    required this.emailUsuario,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.orange[200],
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(top: 10, left: 40, right: 40),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(emailUsuario),
        )
      ),
    );
  }
}