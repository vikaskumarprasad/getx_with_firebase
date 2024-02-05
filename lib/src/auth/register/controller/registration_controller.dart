import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_with_firebase/src/home/view/home_view.dart';

class RegistrationController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  getValidation() async {
    log("getValidation", name: "getValidation");
    if (formKey.currentState!.validate()) {
      log("true");
      formKey.currentState!.save();
      final message = await registration(
        email: emailController.text,
        password: passwordController.text,
      );
      if (message!.contains('Success')) {
        Get.off(const HomeView());
      }
      nameController.clear();
      emailController.clear();
      passwordController.clear();
    } else {
      log("false");
    }
  }

  Future<String?> registration({
    required String email,
    required String password,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
