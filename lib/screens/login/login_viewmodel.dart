import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/base.dart';
// import 'package:flutter/widgets.dart';
import 'package:todo/screens/login/connector.dart';

class LoginViewModel extends BaseViewModel<LoginConnector> {


  void login(String email, String password) async {
    try {
      connector!.showLoading("");
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      connector!.goToHome();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        connector!.showMessage(e.message??"");
      } else if (e.code == 'wrong-password') {
        connector!.showMessage(e.message??"");
      }
    }
    connector!.hideDialog();
  }
}