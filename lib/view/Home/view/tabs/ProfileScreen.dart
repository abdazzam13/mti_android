import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mti_android/routes/app_routes.dart';
import 'package:mti_android/utils/SharedPreferences.dart';
import 'package:mti_android/utils/helper.dart';
import 'package:sqflite/sqflite.dart';
import '../../controller/HomeController.dart';
import 'package:geolocator/geolocator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final HomeController homeController = Get.find();
  var isInternet = false.obs;
  Position? position = Position(
      longitude: 0.00,
      latitude: 0.00,
      timestamp: DateTime.now(),
      accuracy: 0.00,
      altitude: 0.00,
      altitudeAccuracy: 0.00,
      heading: 0.00,
      headingAccuracy: 0.00,
      speed: 0.00,
      speedAccuracy: 0.00);
  ImagePicker picker = ImagePicker();
  File? profilePicture;

  Future pickImageFromGallery() async {
    try {
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        profilePicture = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('gagal mengambil gambar dari galeri $e');
    }
  }

  Future takePictureWithCamera() async {
    try {
      final image = await picker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        profilePicture = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('gagal mengambil gambar dari galeri $e');
    }
  }
  var isLoginByGoogle = SharedPref().getIsLoginByGoogle() ?? false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("photo url: ${SharedPref().getAvatar()}");
    print("display name: ${SharedPref().getName()}");
    Helper().determinePosition().then((value) {
      setState(() {
        position = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset(
            "assets/logo.png",
            width: 70,
            height: 70,
          ),
          centerTitle: true,
        ),
        body: GetBuilder<HomeController>(builder: (controller) {
          if (controller.loading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else {
            return RefreshIndicator(
                child: SingleChildScrollView(
                    child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: isLoginByGoogle
                        ? Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipOval(
                                    child: SizedBox.fromSize(
                                      size: Size.fromRadius(48), // Image radius
                                      child: profilePicture != null
                                          ? Image.file(
                                              profilePicture!,
                                              scale: 0.5,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              "${SharedPref().getAvatar()}"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      bool? isCamera = await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  takePictureWithCamera();
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Camera"),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  pickImageFromGallery();
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Gallery"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                      isCamera!
                                          ? takePictureWithCamera()
                                          : pickImageFromGallery();
                                    },
                                    child: Icon(Icons.edit),
                                  )
                                ],
                              ),
                              Text(
                                "${SharedPref().getName() ?? "Username"}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              position?.longitude != 0.00 && position?.latitude != 0.00 ? Column(
                                children: [
                                  Text("Latitude: ${position?.latitude}"),
                                  Text("Longitude: ${position?.longitude}"),
                                ],
                              ) : CircularProgressIndicator(),
                              ElevatedButton(
                                onPressed: () {
                                  SharedPref.setIsLogin(false);
                                  SharedPref.setUsername("");
                                  Get.offNamed(AppRoutes.login);
                                },
                                child: Text("Logout"),
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.red),
                              )
                            ],
                          )
                        : Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipOval(
                                    child: SizedBox.fromSize(
                                      size: Size.fromRadius(48), // Image radius
                                      child: profilePicture != null
                                          ? Image.file(
                                              profilePicture!,
                                              scale: 0.5,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              "assets/placeholder.png"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      bool? isCamera = await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  takePictureWithCamera();
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Camera"),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  pickImageFromGallery();
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Gallery"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                      isCamera!
                                          ? takePictureWithCamera()
                                          : pickImageFromGallery();
                                    },
                                    child: Icon(Icons.edit),
                                  )
                                ],
                              ),
                              Text(
                                "${SharedPref().getUsername() ?? "Username"}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text("Latitude: ${position?.latitude}"),
                              Text("Longitude: ${position?.longitude}"),
                              ElevatedButton(
                                onPressed: () {
                                  SharedPref.setIsLogin(false);
                                  SharedPref.setUsername("");
                                  Get.offNamed(AppRoutes.login);
                                },
                                child: Text("Logout"),
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.red),
                              )
                            ],
                          ),
                  ),
                )),
                onRefresh: () async {});
          }
        }));
  }
}
