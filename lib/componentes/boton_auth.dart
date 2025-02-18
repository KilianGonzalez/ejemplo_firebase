import 'package:flutter/material.dart';

class BotonAuth extends StatelessWidget {
  final String texto;
  final Function() onTap;

  const BotonAuth({
    super.key,
    required this.texto,
    required this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.pink[300],
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text(
            texto,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 3
            ),
          ),
        ),
      ),
    );
  }
}