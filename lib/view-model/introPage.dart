import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/view/topPage.dart';
import 'package:my_app_flutter/view/homePage.dart';
import 'package:my_app_flutter/view/searchPage.dart';


class IntroPage extends StatefulWidget{
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>{

  //questo seleziona l'indirizzo per controllare la bottom nav bar
  int _selectIndex = 0;

  //Questo metodo aggiorna l'indirizzo selezionato
  //quando l'utente clicca sulla bottom bar
  void navigationBottomBar(int index){
    setState(() {
      _selectIndex = index;
    });
  }

  //le pagine da mostrare
  final List<Widget> _pages = [
    //la pgina di home dove visualizzi le tue statistiche
    HomePage(playerTag: '',),

    //pagina per ricercare gli atlri utenti
    SearchPage(),

    //pagina per visualizzare la top 50 players
    TopPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey.shade600,
      body: _pages[_selectIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectIndex,
        onTap: navigationBottomBar,
        backgroundColor: Colors.grey.shade100,
        color: Colors.pinkAccent,
        animationDuration: Duration(milliseconds: 300),
        items: [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          Icon(
            Icons.local_fire_department_sharp,
            color: Colors.white,
          ),
        ],
      ),
    );

  }
}


