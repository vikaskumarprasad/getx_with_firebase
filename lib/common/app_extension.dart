import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension ExtensionOnBuildContext on BuildContext {
  TextStyle get font12 => Theme.of(this).textTheme.bodySmall!;

  TextStyle get font13 =>
      Theme.of(this).textTheme.bodySmall!.copyWith(fontSize: 13);

  TextStyle get font14 => Theme.of(this).textTheme.titleSmall!;

  TextStyle get font15 =>
      Theme.of(this).textTheme.titleSmall!.copyWith(fontSize: 15);

  TextStyle get font16 => Theme.of(this).textTheme.titleMedium!;

  TextStyle get font17 =>
      Theme.of(this).textTheme.titleMedium!.copyWith(fontSize: 17);

  TextStyle get font18 =>
      Theme.of(this).textTheme.titleMedium!.copyWith(fontSize: 18);

  TextStyle get font19 =>
      Theme.of(this).textTheme.titleMedium!.copyWith(fontSize: 19);

  TextStyle get font20 =>
      Theme.of(this).textTheme.titleLarge!.copyWith(fontSize: 20);

  TextStyle get font21 =>
      Theme.of(this).textTheme.titleLarge!.copyWith(fontSize: 21);

  TextStyle get font22 =>
      Theme.of(this).textTheme.titleLarge!.copyWith(fontSize: 22);

  TextStyle get font23 =>
      Theme.of(this).textTheme.titleLarge!.copyWith(fontSize: 23);

  TextStyle get font24 => Theme.of(this).textTheme.headlineSmall!;

  TextStyle get font25 =>
      Theme.of(this).textTheme.headlineSmall!.copyWith(fontSize: 25);

  TextStyle get font26 =>
      Theme.of(this).textTheme.headlineSmall!.copyWith(fontSize: 26);

  TextStyle get font27 =>
      Theme.of(this).textTheme.headlineSmall!.copyWith(fontSize: 27);

  TextStyle? get font28 => Theme.of(this).textTheme.headlineMedium;

  TextStyle get font29 =>
      Theme.of(this).textTheme.headlineMedium!.copyWith(fontSize: 29);

  TextStyle get font30 =>
      Theme.of(this).textTheme.headlineMedium!.copyWith(fontSize: 30);

  TextStyle get font31 =>
      Theme.of(this).textTheme.headlineMedium!.copyWith(fontSize: 31);

  TextStyle get font32 =>
      Theme.of(this).textTheme.headlineMedium!.copyWith(fontSize: 32);

  TextStyle get font33 =>
      Theme.of(this).textTheme.headlineMedium!.copyWith(fontSize: 33);

  TextStyle get font34 =>
      Theme.of(this).textTheme.headlineMedium!.copyWith(fontSize: 34);

  TextStyle get font35 =>
      Theme.of(this).textTheme.headlineMedium!.copyWith(fontSize: 35);

  TextStyle get font36 => Theme.of(this).textTheme.headlineLarge!;

  hideKeyboard() => FocusScope.of(this).unfocus();

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  showMyBottomSheet(
      {required Widget child,
      bool showCancelButton = false,
      bool? showDragHandle}) {
    showModalBottomSheet(
      context: this,
      showDragHandle: showDragHandle,
      enableDrag: !showCancelButton,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                constraints: BoxConstraints(
                    maxWidth: double.infinity, maxHeight: Get.height * 0.9),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: child,
                ),
              ),
            ),
            if (showCancelButton)
              Positioned(
                top: -20,
                right: 24,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 48,
                    width: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(48),
                      border:
                          Border.all(color: const Color(0xff1A202C), width: 2),
                    ),
                    child: const Icon(Icons.cancel),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void snackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(fontSize: 16)),
      backgroundColor: Colors.redAccent,
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1000),
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(this).size.height - 140, left: 10, right: 10),
    );
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }

  Color generateRandomColor() {
    final Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }
}

// context.generateRandomColor().withOpacity(0.2)
// style: context.font24.copyWith(
// fontWeight: FontWeight.w600, color: AppColors.grey),
