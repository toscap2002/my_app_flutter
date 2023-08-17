import 'package:flutter/material.dart';
import 'package:my_app_flutter/components/listTile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onAbout;
  final void Function()? onProfile;
  final void Function()? onLogout;
  const MyDrawer({super.key, required this.onAbout, required this.onProfile, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            //header
            DrawerHeader(
              child:
              Icon(
                Icons.person,
                color: Colors.white,
                size: 64,
              ),
            ),

            //home lista
            MyList(icon: Icons.description, text: 'A B O U T', onTap: onAbout,
            ),
            //profilo lista
            MyList(icon: Icons.account_circle, text: 'P R O F I L O', onTap: onProfile,
            ),
          ],
          ),
          //logout lista
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyList(icon: Icons.logout, text: 'L O G A U T', onTap: onLogout,
            ),
          ),
        ],
      ),
    );
  }
}
