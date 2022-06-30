import 'package:flutter/material.dart';
import 'package:result_board/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:result_board/screen/auth/onboarding.dart';
import 'package:result_board/screen/home/dashboard.dart';

abstract class AuthRepository {
  Future<AppUser> signInWithEmailAndPassword(String email, String password);
  Future<AppUser> signUpWithEmailAndPassword(String email, String password);
  Future<AppUser> signOut();
  Future<bool> isSignedIn();
}

class AuthRepositoryImpl {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //check if user logged in or not
  Stream<User?> get authStateChange => _auth.authStateChanges();

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      return _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((user) {
        if (user.user != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Login Successful'),
            duration: const Duration(seconds: 2),
            action: SnackBarAction(
              label: 'Close',
              onPressed: () {},
            ),
          ));
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Dashboard();
          }));
        }
      }).catchError((e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {},
          ),
        ));
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ),
      ));
      print(e.toString());
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> signUpWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      return _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
        if (user.user != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Account Successfully Created, please login'),
            duration: const Duration(seconds: 2),
            action: SnackBarAction(
              label: 'Close',
              onPressed: () {},
            ),
          ));
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const OboardingScreen();
          }));
        }
      });
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ),
      ));
    }
  }
}
