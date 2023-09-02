import 'package:flutter/material.dart';
import 'package:my_app_flutter/view-model/components/listTile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onAbout;
  final void Function()? onProfile;
 // final void Function()? onLogout;
  final void Function()? onTutorial;
  final void Function()? onApiKey;
  final void Function()? onTagPage;
  final VoidCallback onLogout; // Definisci la variabile per la funzione di logout
  const MyDrawer({super.key, required this.onAbout, required this.onProfile,     required this.onTutorial, required this.onApiKey, required this.onTagPage, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Drawer(
     // backgroundColor: Colors.grey.shade600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            //header
            DrawerHeader(
              child:
              Icon(
                Icons.person,
                color: Colors.black,
                size: 64,
              ),
            ),

            //home lista
            MyList(icon: Icons.description, text: 'A B O U T', onTap: onAbout,
            ),
            //profilo lista
            MyList(icon: Icons.account_circle, text: 'P R O F I L O', onTap: onProfile,
            ),
            MyList(icon: Icons.key, text: 'A P I   K E Y', onTap: onApiKey,
            ),
            MyList(icon: Icons.tag, text: 'T A G', onTap: onTagPage,
            ),
            MyList(icon: Icons.title_outlined, text: 'T U T O R I A L', onTap: onTutorial,
            ),
          ],
          ),
          //logout lista
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyList(icon: Icons.logout, text: 'L O G O U T', onTap: () {
              Navigator.pop(context); // Chiudi il drawer
              onLogout(); // Richiama la funzione di logout
            },
            ),
          ),
        ],
      ),
    );
  }
}
