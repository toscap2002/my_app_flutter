import 'package:flutter/material.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      //La top 50
      //backgroundColor: Colors.grey.shade600,
        child: Text('La Top 50 !!!!!!'),
      );


  }
}
