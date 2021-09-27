import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './auth.dart';

class Storage {
  final _firestorStorage = FirebaseFirestore.instance; //for data
  final _cloudStorage = FirebaseStorage.instance; //for files like images

  Future<void> createAccount(String id, Map<String, dynamic> accountMap) async {
    final ref =
        await _firestorStorage.collection('users').doc(id).set(accountMap);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getAccount(String id) async {
    return await _firestorStorage.collection('users').doc(id).get();
  }

  Future<String> uploadImage(File image, String accountId) async {
    String url = '';
    final ref =
        _cloudStorage.ref().child('userImage').child(accountId + '.jpg');
    await ref
        .putFile(image)
        .whenComplete(() async => url = await ref.getDownloadURL());
    return url;
  }

  Future<bool> checkUser(String id) async {
    final ref = await _firestorStorage.collection('users').doc(id).get();
    if (ref.exists) {
      return true;
    }
    return false;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getservices() {
    return _firestorStorage.collection('services').get().asStream();
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> getServiceById(String id){

    return _firestorStorage.collection('services').where('ownerId',isEqualTo:id ).get().asStream();
  }

  Future<String> getUserById(String id) async {
    final map = await _firestorStorage.collection('users').doc(id).get();
    return map.data()!['username'];
  }
}
