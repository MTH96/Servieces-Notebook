import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './auth.dart';

class Storage{

final _firestorStorage= FirebaseFirestore.instance;//for data
final _cloudStorage= FirebaseStorage.instance;//for files like images

String createAccount(Map<String, dynamic> accountInfo){
  _firestorStorage.collection('users').add(data)
}


}