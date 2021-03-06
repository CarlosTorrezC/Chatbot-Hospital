import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginService {
  final loginAuth = FirebaseAuth.instance;

  Future<void> signOut() async {
    return await loginAuth.signOut();
  }

  User currentUser() {
    return loginAuth.currentUser;
  }

  Future<User> login(
      String email, String password, BuildContext context) async {
    User user;
    try {
      user = (await loginAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        print('email invalido');
        showToast(context, "email invalido");
      } else if (e.code == 'user-not-found') {
        print('el usuario no existe');
        showToast(context, "el usuario no existe");
      } else if (e.code == 'wrong-password') {
        print('password invalido');
        showToast(context, "password invalido");
      }
    }
    return user;
  }

  Future<UserCredential> register(
      String email, String password, BuildContext context) async {
    UserCredential user;
    try {
      user = await loginAuth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-email') {
        showToast(context, "el email es invalido");
      } else if (e.code == 'weak-password') {
        showToast(context, "password con poco caracteres");
      } else if (e.code == 'email-already-in-use') {
        showToast(context, "el usuario ya existe");
      }
    }
    return user;
  }

  void showToast(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(mensaje),
      duration: Duration(seconds: 2),
    ));
  }
}
