import 'package:flutter/material.dart';

class LateralMenu extends StatelessWidget {
  const LateralMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(),
            accountName: Text("CODEA APP"),
            accountEmail: Text("informes@gmail.com"),
            decoration: BoxDecoration(
              color: Color.fromRGBO(225, 9, 12, 1),
              image: DecorationImage(
                image: AssetImage('assets/images/multi_menu.png'),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
              )
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Inicio"),
            onTap: (){},
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Notificaciones"),
            onTap: (){},
          ),
          ListTile(
            leading: const Icon(Icons.near_me),
            title: const Text("Descuentos cercanos"),
            onTap: (){},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text("Comparte aplicación"),
            onTap: (){},
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("Acerca de Multidescuentos"),
            onTap: () {
              Navigator.popAndPushNamed(context, 'about');
            },
          ),
        ],
      ) ,
    );
  }
}
