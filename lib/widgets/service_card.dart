import 'package:flutter/material.dart';
import 'package:pro/models/service.dart';
import 'package:pro/models/storage.dart';
import 'package:pro/screens/service_screen.dart';

class ServiceCard extends StatelessWidget {
  ServiceCard(this.service, {Key? key}) : super(key: key);
  final Service service;
  final _storage = Storage();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        padding: const EdgeInsets.all(5),
        child: InkWell(
          onTap: () => Navigator.of(context).pushNamed(ServiceScreen.routeName,
              arguments: {'service': service}),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                service.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
              Text(
                'المحتوي :${service.content}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
              Text(
                'التكلفة :${service.fees.toStringAsFixed(2)} جنيه',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
              FutureBuilder(
                  future: _storage.getUserById(service.ownerId),
                  builder: (context, AsyncSnapshot<String?> snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snap.error != null) {
                      return const Text('غير قادر علي معرفة المالك');
                    }
                    return Text(
                      'المالك :${snap.data}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    );
                  })
            ],
          ),
        ));
  }
}
