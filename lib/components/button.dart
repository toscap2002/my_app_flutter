import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyButton extends StatelessWidget{

  final Function()? onTap;
  final String text;

  const MyButton({
    super.key,
    required this.onTap,
    required this.text});

  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary: Colors.purple[400], // Colore di sfondo del pulsante
        onPrimary: Colors.white, // Colore del testo del pulsante
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Bordo arrotondato
        ),
        padding: EdgeInsets.all(25),
        maximumSize: Size(200, 80),
      ),
      child: Center(
          child: Text(
              text,
            style: const TextStyle(
                color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
    ),
    );

  }
}