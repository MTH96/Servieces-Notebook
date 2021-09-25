import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pro/models/auth.dart';
import 'package:pro/screens/home_screen.dart';
import 'package:pro/screens/reg_screen.dart';
import '../widgets/sign_in_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static const routeName = '/auth-screen';
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = Auth();
  void signWithGoogle() async {


      await _auth.signInWithGoogle(context);

      Navigator.of(context).pushReplacementNamed(RegScreen.routeName);

  }

  void signWithFacebook() async {

    if (await _auth.signInWithFacebook(context)) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        width: screenSize.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).colorScheme.primary,
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SignInWithEmail(screenSize: screenSize),
            const SizedBox(height: 10),
            SignInButton(
              ctx: context,
              label: const Text('Sign In With Facebook'),
              icon: Image.asset(
                'assets/images/fb.png',
                height: 35,
              ),
              onPress: signWithFacebook,
            ),
            const SizedBox(height: 10),
            SignInButton(
              ctx: context,
              label: const Text('Sign In With Google'),
              icon: Image.asset(
                'assets/images/google.png',
                height: 30,
              ),
              onPress: signWithGoogle,
            ),
          ],
        ),
      ),
    );
  }
}

class SignInWithEmail extends StatefulWidget {
  const SignInWithEmail({Key? key, required this.screenSize}) : super(key: key);
  final Size screenSize;
  @override
  _SignInWithEmailState createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {
  bool isSignIn = true;
  bool showPassword = false;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String rePassword = '';
  final passwordCtrl = TextEditingController();

  final _auth = Auth();
  void signWithEmail() async {

      isSignIn
          ? await _auth.signInWithEmail(context,email, password)
          : await _auth.signUpWithEmail(context,email, password);

    if (_auth.isSignedIn()) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: widget.screenSize.width * .6,
              transform: Matrix4.skewX(50),
              child: Text(
                isSignIn ? 'Sign In' : 'Sign Up',
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: widget.screenSize.width * .6,
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) {
                        if (!EmailValidator.validate(val!)) {
                          return 'please enter a valid email';
                        }
                      },
                      decoration: const InputDecoration(
                          label: Text('email'),
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ))),
                      onFieldSubmitted: (str) => email = str.trim(),
                      onChanged:(str) => setState(() {
                        email = str.trim();
                      }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onFieldSubmitted: (str) => password = str,
                      validator: (val) {
                        if (val!.length < 8) {
                          return 'password is too short';
                        }
                      },
                      controller: passwordCtrl,
                      decoration: InputDecoration(
                          label: const Text('password'),
                          prefixIcon: Icon(
                            showPassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ))),
                      obscureText: !showPassword,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 300,
                      ),
                      curve: Curves.bounceOut,
                      height: isSignIn ? 0 : 50,
                      child: TextFormField(
                        onFieldSubmitted: (str) => rePassword = str,
                        validator: (val) {
                          if (!isSignIn && val != passwordCtrl.text) {
                            return 'password doesn\'t match!';
                          }
                        },
                        decoration: isSignIn
                            ? const InputDecoration(border: InputBorder.none)
                            : InputDecoration(
                                label: const Text('password'),
                            prefixIcon: Icon(
                                  showPassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                                border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ))),
                        obscureText: !showPassword,
                      ),
                    ),
                    CheckboxListTile(
                      title: const Text('Show password'),
                      value: showPassword,
                      onChanged: (val) {
                        setState(() {
                          showPassword = val!;
                        });
                      },
                    ),
                    TextButton(
                        onPressed: () => setState(() {
                              isSignIn = !isSignIn;
                            }),
                        child: Text(isSignIn ? 'Sign Up' : 'Sign In',
                            style: Theme.of(context).textTheme.bodyText1)),
                    SignInButton(
                      ctx: context,
                      label: Text(isSignIn
                          ? 'Sign In With email/password'
                          : 'Sign Up With email/password'),
                      icon: const Icon(
                        Icons.email,
                        size: 30,
                      ),
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          print('email : $email');
                          print('pass: $password');
                         signWithEmail();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}