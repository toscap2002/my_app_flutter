import 'package:flutter/material.dart';
import 'package:my_app_flutter/components/logo.dart';
import 'package:my_app_flutter/components/textfield.dart';

class ApiKeyPage extends StatefulWidget {
   ApiKeyPage({super.key});

  @override
  State<ApiKeyPage> createState() => _ApiKeyPageState();
}

class _ApiKeyPageState extends State<ApiKeyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API KEY'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      backgroundColor: Colors.grey[100],
      body:  const SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                //logo
                Logo(),

                SizedBox(height: 25),

                Center(
                  child: Text(
                      'Inserisci nello spazio sottostante l\'api key!\nRicorda di usare l\'indirizzo IP del tuo telefono (Per conoscere l\'IP del tuo smartphonevai su whatsmyip)',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),

                SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black87),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 5, color: Colors.orange),
                      ),focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 5, color: Colors.amber),
                    ),
                      fillColor: Colors.white38,
                      filled: true,
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
