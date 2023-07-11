import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image/image_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'confirm_image_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Image Picker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Image Picker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var controller = Get.put(ImageController());

  Future pickImage(ImageSource imageSource) async {
    XFile? image =
        await ImagePicker().pickImage(source: imageSource, imageQuality: 50);
    return image;
  }

  void uploadPODBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Spacer(),
                      const Center(
                        child: Text(
                          "Select Type of POD",
                          style: TextStyle(
                            color: Color(0xFF211D1E),
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: SvgPicture.asset(
                            'assets/images/cancel.svg',
                            color: const Color(0xFF211D1E),
                            width: 16,
                            height: 16,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              // Close the bottom sheet
                              Get.back();

                              XFile? photo =
                                  await pickImage(ImageSource.camera);
                              if (photo != null) {
                                Get.to(
                                  () => ConfirmImageScreen(
                                    photo.path,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                border:
                                    Border.all(color: const Color(0XFFD2D2D2)),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Icon(Icons.camera_alt_rounded),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Camera',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              Get.back();
                              XFile? photo =
                                  await pickImage(ImageSource.gallery);
                              if (photo != null) {
                                Get.to(() => ConfirmImageScreen(
                                      photo.path,
                                    ));
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                border: Border.all(
                                  color: const Color(0XFFD2D2D2),
                                ),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Icon(Icons.photo_library_rounded),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Gallery',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: Obx(
        () => controller.imagePath.isEmpty
            ? const Text('Please Select Image')
            : Image.file(
                File(controller.imagePath.value),
                fit: BoxFit.contain,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .8,
              ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: uploadPODBottomSheet,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
