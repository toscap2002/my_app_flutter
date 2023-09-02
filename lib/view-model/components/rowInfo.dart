import 'package:flutter/material.dart';

class RowInfo extends StatelessWidget {
  final String label;
  final String value;

  RowInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Row(
           children: [
             Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
             SizedBox(width: 8), // Spazio tra label e valore
             Text(value),
           ],
         ),
        SizedBox(height: 16), // Spazio maggiore tra valore e label successivo
      ],
    );
  }
}
