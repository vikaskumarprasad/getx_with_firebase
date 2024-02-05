import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';

class HomeController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  RxList<UserModel> userList = <UserModel>[].obs;

  Future<void> addUser() {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users.add({
      'title': titleController.text, // John Doe
      'name': nameController.text, // Stokes and Sons
      'description': descriptionController.text, // 42
    }).then(
      (value) {
        log("User Added", name: "Added");
        fetchUsers();
      },
    ).catchError(
      (error) => log("Failed to add user: $error", name: "Failed"),
    );
  }

  Future<void> fetchUsers() {
    userList.clear();
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users.get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        userList.add(
          UserModel.fromJson(doc.data()),
        );
      }
    }).catchError(
      (error) =>
          log("Failed to fetch users: ${error}", name: "Failed fetch users"),
    );
  }

  deleteUser() {}
}
