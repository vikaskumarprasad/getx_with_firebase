import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_with_firebase/src/home/view/home_view.dart';

class CreateAccountController extends GetxController {
  File? image;
  RxString uploadedImage = "".obs;
  RxString selectedDate = ''.obs;
  RxBool isMale = true.obs;
  RxBool isLoading = false.obs;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  Future<void> createAccount() async {
    log("image==>${image!.path}", name: "image");
    log("firstNameController==>${firstNameController.text}",
        name: "firstNameController");
    log("middleNameController==>${middleNameController.text}",
        name: "middleNameController");
    log("lastNameController==>${lastNameController.text}",
        name: "lastNameController");
    log("addressController==>${addressController.text}",
        name: "addressController");
    log("phoneNumberController==>${phoneNumberController.text}",
        name: "phoneNumberController");
    log("emailController==>${emailController.text}", name: "emailController");
    log("selectedDate==>${selectedDate.value}", name: "selectedDate");
    log("isMale==>${isMale.value}", name: "isMale");

    CollectionReference users =
        FirebaseFirestore.instance.collection('users_main');
    return users.add({
      'id': 1,
      'first_name': firstNameController.text,
      'middle_name': middleNameController.text,
      'last_name': lastNameController.text,
      'email': emailController.text,
      'address': addressController.text,
      'phone_number': addressController.text,
      'dob': selectedDate.value,
      'gender': isMale.value,
      'profile_image': uploadedImage.value,
    }).then(
      (value) {
        log("User Added", name: "Added");
        Get.off(const HomeView());
        // titleController.clear();
        // nameController.clear();
        // descriptionController.clear();
        // fetchUsers();
      },
    ).catchError(
      (error) {
        log("Failed to add user: $error", name: "FailedAdd");
      },
    );
  }

  Future<void> fetchUsers() {
    CollectionReference users =
        FirebaseFirestore.instance.collection('users_main');
    return users.get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        // list.add(doc.id);
        // userList.add(
        //   UserModel.fromJson(doc.data()),
        // );
        print("snapshot.docs${doc.data()}");
        print("snapshot.docs${doc.id}");
      }
    }).catchError(
      (error) {
        log("Failed to fetch users: $error", name: "FetchUsers");
      },
    );
  }

  Future getDownloadURL() async {
    isLoading.value = true;
    print("isLoading.value${isLoading.value}");
    print("object");
    if (image != null) {
      var imageName = DateTime.now().millisecondsSinceEpoch.toString();
      var storageRef =
          FirebaseStorage.instance.ref().child('profile/$imageName.jpg');
      var uploadTask = storageRef.putFile(image!);
      var downloadUrl = await (await uploadTask).ref.getDownloadURL();
      List<String> parts = downloadUrl.split("?");
      if (parts.isNotEmpty) {
        isLoading.value = false;
        print("isLoading.value${isLoading.value}");
        String baseUrl = parts[0];
        uploadedImage.value = baseUrl;
        log("Extracted URL: $baseUrl");
      } else {
        log("Invalid URL format");
      }
      log("downloadUrl$downloadUrl");
    }
  }
}
