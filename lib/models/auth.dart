import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Auth {
  final _auth = FirebaseAuth.instance;



  get user => _auth.currentUser;
 bool isSignedIn() {
    bool isSigned = false;
    if ( _auth.currentUser != null) {
    // signed in
    isSigned = true;
    } else {
    isSigned = false;
    }


    return isSigned;
  }

  Future<void> signInWithEmail(BuildContext context,
       String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(context: context, builder: (context)=>AlertDialog(

          title: const Text('error'),
          content: const Text('No user found for that email'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Ok'))
          ],
        )) ;
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showDialog(context: context, builder: (context)=>AlertDialog(

          title: const Text('error'),
          content: const Text('Wrong password provided for that user.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Ok'))
          ],
        ));
        print('Wrong password provided for that user.');
      }
    }
    catch(e)
    {
      rethrow ;
    }
  }

  Future<void> signUpWithEmail(
      BuildContext ctx, String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        await  showDialog(context: ctx, builder: (ctx)=> AlertDialog(
          title: const Text('error'),
          content: const Text('The password provided is too weak.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Ok'))
          ],)
        );
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        await  showDialog(context: ctx, builder: (ctx)=> AlertDialog(
          title: const Text('error'),
          content: const Text('The account already exists for that email.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Ok'))
          ],)
        );
        print('The account already exists for that email.');
      }
    } catch (e) {
      await  showDialog(context: ctx, builder: (ctx)=> AlertDialog(
        title: const Text('error'),
        content: Text(e.toString()),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(), child: const Text('Ok'))
        ],)
      );
      print(e);
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try{
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await _auth.signInWithCredential(credential);
    }
  catch (e)
  {

  await  showDialog(context: context, builder: (ctx)=> AlertDialog(
    title: const Text('error'),
  content: Text(e.toString()),
  actions: [
  TextButton(
  onPressed: () => Navigator.of(ctx).pop(), child: const Text('Ok'))
  ],
  ))
  ;
  }
  }

  Future<bool> signInWithFacebook(BuildContext ctx,) async {
   try{ // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    await _auth.signInWithCredential(facebookAuthCredential);
    return true;}
  catch(e)
  {  await  showDialog(context: ctx, builder: (ctx)=> AlertDialog(
    title: const Text('error'),
  content: Text(e.toString()),
  actions: [
  TextButton(
  onPressed: () => Navigator.of(ctx).pop(), child: const Text('Ok'))
  ],)
  );
  print(e);
  }
  return false;
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
