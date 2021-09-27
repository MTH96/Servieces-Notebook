import 'package:flutter/material.dart';
import 'package:pro/widgets/drawer_tab.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({Key? key}) : super(key: key);
  static const routeName = '/add-services-screen';

  @override
  _AddServiceScreenState createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerTab(),
    );
  }
}
