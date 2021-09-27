import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pro/models/auth.dart';
import 'package:pro/models/service.dart';
import 'package:pro/models/storage.dart';
import 'package:pro/widgets/drawer_tab.dart';
import 'package:pro/widgets/service_card.dart';

class MyServiecesScreen extends StatefulWidget {
  const MyServiecesScreen({Key? key}) : super(key: key);
  static const routeName = '/my-services-screen';

  @override
  _MyServiecesScreenState createState() => _MyServiecesScreenState();
}

class _MyServiecesScreenState extends State<MyServiecesScreen> {
  final _storage = Storage();
  final _auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerTab(),
      body: StreamBuilder(
          stream: _storage.getServiceById(_auth.user!.uid),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>?>
                  servicesSnapshot) {
            if (servicesSnapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator.adaptive();
            }
            if (servicesSnapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('لا يوجد خدمات مضافة بعد'),
              );
            }

            final docs = servicesSnapshot.data!.docs;
            return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final service = Service();
                  service.fromMap(map: docs[index].data(), id: docs[index].id);

                  return ServiceCard(service);
                });
          }),
    );
  }
}
