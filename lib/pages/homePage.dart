import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/components/drawer.dart';
import 'package:my_app_flutter/pages/about.dart';
import 'package:my_app_flutter/pages/profilePage.dart';
import 'package:provider/provider.dart';
import 'package:my_app_flutter/pages/authService.dart';


class HomePage extends StatefulWidget{
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {




  //Metodo di logout
  void logoutUser() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.logoutUser();
  }

  void goToProfilePage(){
    //pop menu drawer
    Navigator.pop(context);
    //go to profile page
     Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(),
      ),
    );
  }

  void goToAboutPage(){
    //pop menu drawer
    Navigator.pop(context);
    //go to about page
    Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage(),
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade600,
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      drawer: MyDrawer(
        onAbout: goToAboutPage,
        onProfile: goToProfilePage,
        onLogout: logoutUser,
      ),
    );

  }
}


