import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../network/api/googleSignInApi.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/SharedPreferences.dart';

class LoginController extends GetxController {

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  Future<User?> loginByGoogle(BuildContext context) async {
    final user = await LoginByGoogle.signInWithGoogle(context: context);

    if (user != null) {
      print("user $user");
      SharedPref.setEmail(user.email!);
      SharedPref.setName(user.displayName!);
      if (user.photoURL != null) {
        SharedPref.setAvatar(user.photoURL!);
      } else {
        SharedPref.setAvatar(
            "https://drive.google.com/uc?id=1D7xEdFnGn9OI6Qygo-dEsZ2OEG6V8nrk");
      }
      SharedPref.setIsLogin(true);
      SharedPref.setIsLoginByGoogle(true);
      Get.offNamed(AppRoutes.home);
      return user;
    }
  }

}