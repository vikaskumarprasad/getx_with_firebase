import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_with_firebase/common/app_extension.dart';
import 'package:getx_with_firebase/src/account/create_account_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  CreateAccountController createAccountController =
      Get.put(CreateAccountController());

  Future<void> _requestCameraAndGalleryPermissions() async {
    var cameraStatus = await Permission.camera.status;
    if (cameraStatus.isDenied) {
      await Permission.camera.request();
    } else {
      var galleryStatus = await Permission.photos.status;
      if (galleryStatus.isDenied) {
        await Permission.photos.request();
      }
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    var status = await Permission.camera.status;

    if (status.isGranted) {
      // Camera permission is granted
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          createAccountController.image = File(pickedFile.path);
        });
      }
    } else {
      // Camera permission is not granted
      // Handle accordingly (show a message, ask for permission again, etc.)
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime minimumAllowedBirthDate =
        DateTime(now.year - 18, now.month, now.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: minimumAllowedBirthDate,
      firstDate: DateTime(now.year - 100),
      lastDate: minimumAllowedBirthDate,
    );
    if (picked != null) {
      setState(() {
        createAccountController.selectedDate.value =
            DateFormat('dd-MM-yyyy').format(now);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Create Account",
          style: context.font22.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
        child: SingleChildScrollView(
          child: Obx(() {
            return Column(
              children: [
                InkResponse(
                  radius: 22,
                  overlayColor: MaterialStatePropertyAll(
                    Colors.deepPurple.shade100,
                  ),
                  onTap: () {
                    context.hideKeyboard();
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 180,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: () async {
                                    await _requestCameraAndGalleryPermissions();
                                    _pickImage(ImageSource.camera);
                                    Get.back();
                                  },
                                  title: const Text(
                                    'Open camera',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                ListTile(
                                  onTap: () async {
                                    await _requestCameraAndGalleryPermissions();
                                    _pickImage(ImageSource.gallery);
                                    Get.back();
                                  },
                                  title: const Text(
                                    'Select picture from gallery',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: createAccountController.image != null
                          ? Image.file(createAccountController.image!,
                                  fit: BoxFit.cover)
                              .image
                          : null,
                      backgroundColor: const Color(0xffE1E6EF),
                      child: Text(
                        createAccountController.image != null ? "" : "Upload",
                        style: context.font14.copyWith(
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff58759F),
                        ),
                      ),
                    ),
                  ),
                ),
                CommonTextField(
                  controller: createAccountController.firstNameController,
                  labelText: "First Name",
                ),
                CommonTextField(
                  controller: createAccountController.middleNameController,
                  labelText: "Middle Name",
                ),
                CommonTextField(
                  controller: createAccountController.lastNameController,
                  labelText: "Last Name",
                ),
                CommonTextField(
                  controller: createAccountController.emailController,
                  labelText: "Email",
                ),
                CommonTextField(
                  controller: createAccountController.addressController,
                  labelText: "Address",
                ),
                CommonTextField(
                  controller: createAccountController.phoneNumberController,
                  labelText: "Phone Number",
                ),
                RadioListTile(
                  title: const Text('Male'),
                  value: true,
                  groupValue: createAccountController.isMale.value,
                  onChanged: (bool? value) {
                    context.hideKeyboard();
                    setState(() {
                      createAccountController.isMale.value = value!;
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Female'),
                  value: false,
                  groupValue: createAccountController.isMale.value,
                  onChanged: (bool? value) {
                    context.hideKeyboard();
                    setState(() {
                      createAccountController.isMale.value = value!;
                    });
                  },
                ),
                InkWell(
                  onTap: () => _selectDate(context),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: createAccountController.selectedDate.value.isNotEmpty
                        ? Text(createAccountController.selectedDate.value)
                        : const Text("DOB"),
                  ),
                ),
                Obx(() {
                  return SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          ContinuousRectangleBorder(),
                        ),
                      ),
                      onPressed: () async {
                        context.hideKeyboard();
                        await createAccountController.getDownloadURL();
                        await createAccountController.createAccount();
                        // await createAccountController.fetchUsers();
                      },
                      child: createAccountController.isLoading.value
                          ? const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(strokeWidth: 5),
                            )
                          : Text(
                              "Create Account",
                              style: context.font22
                                  .copyWith(color: Colors.deepPurple),
                            ),
                    ),
                  );
                }),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;

  const CommonTextField({
    super.key,
    required this.controller,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText ?? '',
        ),
      ),
    );
  }
}
