import 'package:flutter/material.dart';
import 'package:pro/models/account.dart';
import 'package:pro/models/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:pro/screens/add_service_screen.dart';
import 'package:pro/screens/myservices_dart.dart';
import 'package:pro/screens/service_screen.dart';
import 'package:provider/provider.dart';
import 'package:pro/screens/reg_screen.dart';
import 'screens/auth_screen.dart';
import './screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Account(
        address: '',
        birthday: DateTime.now(),
        email: '',
        imageUrl: '',
        phone: '',
        username: '',
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primaryColor: Colors.white,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                onPrimary: Colors.white,
                primary: Colors.blue,
                secondary: Colors.indigo,
              ),
          textTheme: const TextTheme().copyWith(
            bodyText1: const TextStyle(color: Colors.white),
          ),
        ),
        routes: {
          AuthScreen.routeName: (ctx) => const AuthScreen(),
          HomeScreen.routeName: (ctx) => const HomeScreen(),
          RegScreen.routeName: (ctx) => const RegScreen(),
          MyServiecesScreen.routeName: (ctx) => const MyServiecesScreen(),
          ServiceScreen.routeName: (ctx) => const ServiceScreen(),
          AddServiceScreen.routeName: (ctx) => const AddServiceScreen(),
        },
        home: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final _auth = Auth();
  @override
  Widget build(BuildContext context) {
    if (_auth.isSignedIn()) {
      return const RegScreen();
    } else {
      return const AuthScreen();
    }
  }
}
