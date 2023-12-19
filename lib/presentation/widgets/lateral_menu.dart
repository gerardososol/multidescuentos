import 'package:flutter/material.dart';

class LateralMenu extends StatelessWidget {
  const LateralMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text("CODEA APP"),
            accountEmail: Text("informes@gmail.com"),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("https://multidescuentos.com.mx/logos/encab3.jpg"),
                    fit: BoxFit.cover
                )
            ),
          ),
          ListTile(
            title: const Text("Inicio"),
            onTap: (){},
          ),
          const ListTile(
            title: Text("Notificaciones"),
          ),
          const ListTile(
            title: Text("Descuentos cercanos"),
          ),
          const ListTile(
            title: Text("Acerca de Multidescuentos"),
          )

        ],
      ) ,
    );
  }
}
