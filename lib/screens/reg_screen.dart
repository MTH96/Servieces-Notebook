import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pro/models/account.dart';
import 'package:pro/models/storage.dart';
import 'package:pro/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:pro/widgets/drawer_tab.dart';
import 'package:pro/widgets/image_box.dart';
import 'package:email_validator/email_validator.dart';

import '../models/auth.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);
  static const routeName = '/reg-screen';

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final User? user = Auth().user;
  final _form = GlobalKey<FormState>();
  DateTime? birthday;
  String imageUrl = '';
  bool isServiceProvider = false;
  late Account _account;

  void saveImage(String imageUrl) => setState(() {
        this.imageUrl = imageUrl;
      });

  Map<String, String> inputs = {
    'name': '',
    'phone': '',
    'address': '',
  };
  static final Map<String, String> labels = {
    'name': 'اسم المستخدم',
    'phone': 'رقم التليفون',
    'address': 'العنوان',
  };
  static final Map<String, IconData> icons = {
    'name': Icons.person,
    'phone': Icons.phone,
    'address': Icons.my_location,
  };
  Map<String, String? Function(String?)> validator = {
    'name': (str) {
      if (str!.isEmpty) {
        return 'خطأ لا يمكن ترك هذه الخانة فارغة';
      }
      return '';
    },
    'phone': (str) {
      if (str!.isEmpty) {
        return 'خطأ لا يمكن ترك هذه الخانة فارغة';
      }

      // You may need to change this pattern to fit your requirement.
      // I just copied the pattern from here: https://regexr.com/3c53v
      const pattern = r'^(?:\+2)?01\d{9}$';
      final regExp = RegExp(pattern);

      if (!regExp.hasMatch(str)) {
        return 'خطأ رقم الهاتف غير صالح';
      }
      return '';
    },
    'address': (str) {
      if (str!.isEmpty) {
        return 'خطأ لا يمكن ترك هذه الخانة فارغة';
      }
      return '';
    },
  };
  bool birthdayValidation() {
    if (birthday!.isAfter(DateTime.now())) {
      return false;
    }
    return true;
  }

  void formSubmitting() async {
    if (_form.currentState!.validate() &&
        birthdayValidation() &&
        imageUrl.isNotEmpty) {
      _form.currentState!.save();
      _account.address = inputs['address'];
      _account.username = inputs['name'];
      _account.phone = inputs['phone'];
      _account.imageUrl = imageUrl;
      _account.id = Auth().user!.uid;
      _account.birthday = birthday;
      _account.email = Auth().user!.email;
      final _storage = Storage();
      await _storage.createAccount(_account.id, _account.toMap());
      _account.notifyChanges();
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }

  List<Widget> inputBuilder() {
    List<Widget> inputList = [];
    inputs.forEach((key, value) {
      inputList.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(
                labelText: labels[key],
                prefixIcon: Icon(icons[key]),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ))),
            validator: validator[key],
          ),
        ),
      );
    });
    return inputList;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    _account = Provider.of<Account>(context);

    return Scaffold(
        drawer: DrawerTab(),
        appBar: AppBar(
          title: const Text('إنشاء حساب جديد'),
        ),
        body: Form(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ImageBox(
                          width: screenSize.width * .5,
                          height: 150,
                          imageSavingFn: saveImage,
                        ),
                      ),
                      ...inputBuilder(),
                      ListTile(
                        trailing: const Text('تاريخ الميلاد '),
                        leading: ElevatedButton(
                          child: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            birthday = await showDatePicker(
                              context: context,
                              initialDate: DateTime(
                                1996,
                              ),
                              firstDate: DateTime(1986),
                              lastDate: DateTime.now(),
                            );
                          },
                        ),
                      ),
                      ListTile(
                        trailing: const Text('موفر خدمات'),
                        title: Switch.adaptive(
                            value: isServiceProvider,
                            onChanged: (val) => setState(() {
                                  isServiceProvider = val;
                                })),
                        leading: const Text('مستقبل خدمات'),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: formSubmitting, child: const Text('إنشاء حساب'))
            ],
          ),
        ));
  }
}


// curl -H 'Authorization: token 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
// git push https://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@github.com/MTH96/Servieces-Notebook.git
//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
//git push https://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@github.com/MTH96/Servieces-Notebook.git
// https://github.com/MTH96/Servieces-Notebook.git/'
