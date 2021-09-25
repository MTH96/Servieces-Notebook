import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pro/widgets/drawer_tab.dart';
import 'package:pro/widgets/edit_box.dart';
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

  DateTime? birthday;
  Map<String, String> inputs = {
    'name': '',
    'phone': '',
    'email': '',
    'address': '',
  };
  static final List<String> labels = [
    'اسم المستخدم',
    'رقم التليفون',
    'ايميل المستخدم',
    'العنوان',
  ];
  static final List<IconData> icons = [
    Icons.person,
    Icons.phone,
    Icons.email,
    Icons.my_location,
  ];
  Map<String, String Function(String)> validator = {
    'name': (str) {
      if (str.isEmpty) {
        return 'خطأ لا يمكن ترك هذه الخانة فارغة';
      }
      return '';
    },
    'phone':
        (str) {
      if (str.isEmpty) {
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
    'email': (str) {
      if (!EmailValidator.validate(str)) {
        return 'من فضلك ادخل ايميل صحيح';
      }
      return '';
    },
    'address': (str) {
      if (str.isEmpty) {
        return 'خطأ لا يمكن ترك هذه الخانة فارغة';
      }
      return '';
    },
  };

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery
        .of(context)
        .size;

    return Scaffold(
        drawer: DrawerTab(),
        appBar: AppBar(
          title: const Text('create your profile'),
        ),
        body: Form(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: EditBox(
                    width: screenSize.width * .5,
                    height: 150,
                    onPress: () {},
                    child: user!.photoURL != null
                        ? Image.network(
                      user!.photoURL.toString(),
                      width: 200,
                      fit: BoxFit.fitWidth,
                    )
                        : const Text(
                      'add you profile image',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                 ListView.builder(
                    itemCount: labels.length,
                    itemBuilder: (context, index) {
                      final String key = inputs.keys.elementAt(index);

                      // inputs.map((key, value) => null)
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: labels[index],
                              prefixIcon: Icon(icons[index]),
                              border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ))),
                          validator: (str) {},
                        ),
                      );
                    },
                  ),

                ListTile(trailing: Text('تاريخ الميلاد '),
                  leading: ElevatedButton(child: Icon(Icons.calendar_today), onPressed: () async{
                  birthday=await  showDatePicker(context: context,
                        initialDate: DateTime(1996,),
                        firstDate: DateTime(1986),
                        lastDate: DateTime.now(),
                        );
                  },),)
              ],
            ),
          ),
        ));
  }
}


curl -H 'Authorization: token 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
git push https://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@github.com/MTH96/Servieces-Notebook.git
https://github.com/MTH96/Servieces-Notebook.git/'