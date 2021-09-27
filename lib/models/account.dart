import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Account with ChangeNotifier {
  late String id;
  String? username;
  String? email;
  String? phone;
  String? imageUrl;
  String? address;
  DateTime? birthday;
  bool? isServiceProvide;

  Account({
    this.id = '',
    required this.address,
    required this.birthday,
    required this.email,
    required this.imageUrl,
    required this.phone,
    required this.username,
     this.isServiceProvide=false,
  }) {
    notifyListeners();
  }

  void fromMap(Map<String, dynamic>? map, String id) {
    address = map!['address'];
    birthday = (map['birthday'] as Timestamp).toDate();
    email = map['email'];
    imageUrl = map['imageUrl'];
    phone = map['phone'];
    username = map['username'];
    isServiceProvide = map['is_sp'];
    this.id = id;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'address': address,
      'birthday': birthday!.toIso8601String(),
      'email': email,
      'imageUrl': imageUrl,
      'phone': phone,
      'username': username,
      'is_sp': isServiceProvide,
    };
    return map;
  }

  void notifyChanges() {
    notifyListeners();
  }
}
