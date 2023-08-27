import 'package:flutter/material.dart';

class RowInfo extends StatelessWidget {
  final String label;
  final String value;

  RowInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150, // Larghezza fissa per l'etichetta
          child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(value),
        ),
      ],
    );
  }
}
