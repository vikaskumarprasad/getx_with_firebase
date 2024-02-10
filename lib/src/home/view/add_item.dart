import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_with_firebase/common/app_extension.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../controller/home_controller.dart';

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({super.key});

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
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
          homeController.image = File(pickedFile.path);
        });
      }
    } else {
      // Camera permission is not granted
      // Handle accordingly (show a message, ask for permission again, etc.)
    }
  }

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add user"),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: CircleAvatar(
                radius: 45,
                backgroundImage: homeController.image != null
                    ? Image.file(homeController.image!, fit: BoxFit.cover).image
                    : null,
                backgroundColor: const Color(0xffE1E6EF),
                child: Text(
                  homeController.image != null ? "" : "Upload",
                  style: context.font14.copyWith(
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff58759F)),
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                await _requestCameraAndGalleryPermissions();
                _pickImage(ImageSource.camera);
                // Get.back();
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
                // Get.back();
              },
              title: const Text(
                'Select picture from gallery',
                textAlign: TextAlign.center,
              ),
            ),
            TextField(
              controller: homeController.titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: homeController.nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: homeController.descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            ElevatedButton(
              onPressed: () async {
                context.hideKeyboard();
                await homeController.addUser();
                Get.back();
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
