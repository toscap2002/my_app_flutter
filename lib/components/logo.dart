import 'package:flutter/material.dart';

class Logo extends StatelessWidget{
  const Logo({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        width: 100,
        child: Image.asset('lib/images/coclogo.png'),
      ),
    );
  }
}