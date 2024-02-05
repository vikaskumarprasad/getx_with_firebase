import 'dart:async';
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
  RxList<String> list = <String>[].obs;
  RxBool isUpdate = false.obs;
  RxBool isLoading = true.obs;

  Future<void> addUser() {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users.add({
      'title': titleController.text,
      'name': nameController.text,
      'description': descriptionController.text,
    }).then(
      (value) {
        log("User Added", name: "Added");
        titleController.clear();
        nameController.clear();
        descriptionController.clear();
        fetchUsers();
      },
    ).catchError(
      (error) {
        log("Failed to add user: $error", name: "FailedAdd");
      },
    );
  }

  Future<void> fetchUsers() {
    isLoading.value = true;
    userList.clear();
    list.clear();
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users.get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        list.add(doc.id);
        userList.add(
          UserModel.fromJson(doc.data()),
        );
      }
      Timer(const Duration(seconds: 3), () {
        isLoading.value = false;
      });
    }).catchError(
      (error) {
        log("Failed to fetch users: $error", name: "FetchUsers");
      },
    );
  }

  Future<void> deleteUser({required String userId}) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users.doc(userId).delete().then(
      (value) {
        log("User deleted successfully!", name: "Deleted");
        fetchUsers();
      },
    ).catchError(
      (error) {
        log("Failed to delete user: $error", name: "Deleted");
      },
    );
  }

  Future<void> fetchUsersByName({required String name}) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .where('name', arrayContains: name)
        .get()
        .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        log('searfajksdfl====>${doc.id} => ${doc.data()}');
      }
    }).catchError((error) {
      log("Failed to fetch users: $error");
    });
  }
}
