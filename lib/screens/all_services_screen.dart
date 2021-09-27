import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pro/models/service.dart';
import 'package:pro/models/storage.dart';
import 'package:pro/widgets/drawer_tab.dart';
import 'package:pro/widgets/service_card.dart';


class AllServicesScreen extends StatefulWidget {
  const AllServicesScreen({ Key? key }) : super(key: key);
static const routeName='/all-services-screen';
  @override
  _AllServicesScreenState createState() => _AllServicesScreenState();
}

class _AllServicesScreenState extends State<AllServicesScreen> {
  final _storage=Storage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerTab(),
      body: StreamBuilder(
        stream: _storage.getservices(),
        
        builder: (context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>?> servicesSnapshot){

if (servicesSnapshot.connectionState==ConnectionState.waiting) {
  return const CircularProgressIndicator.adaptive();
  
} 
  if(servicesSnapshot.data!.docs.isEmpty){
    return const Center(child: Text('لا يوجد خدمات مضافة بعد'),);
  }
  
final docs=servicesSnapshot.data!.docs; 
return ListView.builder(
  itemCount: docs.length,

  itemBuilder:(context,index){ 
    final service=Service();
    service.fromMap(map:docs[index].data(),id:docs[index].id);
    
   return ServiceCard(service);});


        

        }),
      
    );
  }
}