import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pro/models/account.dart';
import 'package:pro/screens/add_service_screen.dart';
import 'package:pro/screens/myservices_dart.dart';
import 'package:provider/provider.dart';

import '../models/auth.dart';

class DrawerTab extends StatefulWidget {
  static const routeName = 'drawer';

  @override
  _DrawerTabState createState() => _DrawerTabState();
}

class _DrawerTabState extends State<DrawerTab> {
  final _auth = Auth();

  Widget buildListTile(
      {required IconData icon,
      required String title,
      required Function()? onTapHandler,
      Widget? trialingWidget}) {
    return ListTile(
      leading: Icon(
        icon,
        size: 40,
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      trailing: trialingWidget,
      onTap: onTapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _account = Provider.of<Account>(context, listen: false);
    return Drawer(
      child: Column(
        children: [
          Stack(children: [
            Container(
              height: 150,
              color: Theme.of(context).colorScheme.secondary,
              alignment: Alignment.center,
              child: const Text('SP',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
          ]),
          const SizedBox(
            height: 5,
          ),
          if (_account.isServiceProvide ?? false)
            buildListTile(
              icon: Icons.add,
              title: 'اضافة خدمة جديدة',
              onTapHandler: () =>
                  Navigator.of(context).pushNamed(AddServiceScreen.routeName),
            ),
          buildListTile(
            icon: Icons.add,
            title: ' خدماتي ',
            onTapHandler: () =>
                Navigator.of(context).pushNamed(MyServiecesScreen.routeName),
          ),
          buildListTile(
            icon: Icons.exit_to_app_rounded,
            title: 'تسجيل خروج',
            onTapHandler: () => _logOut(),
          ),
        ],
      ),
    );
  }

  void _logOut() {
    _auth.logOut();
    Navigator.of(context).pushReplacementNamed('/');
  }
}
