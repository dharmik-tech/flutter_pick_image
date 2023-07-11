import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image/image_controller.dart';
import 'package:get/get.dart';

class ConfirmImageScreen extends StatelessWidget {
  String image;
  var controller = Get.put(ImageController());

  ConfirmImageScreen(
    this.image, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Image.file(
              File(image),
              fit: BoxFit.contain,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .8,
            )),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 32),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () async {
                        controller.imagePath.value = image;
                        Get.back();
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.done,
                        size: 50,
                      )),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.cancel,
                        size: 50,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
