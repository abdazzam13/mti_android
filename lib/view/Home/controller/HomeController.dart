import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mti_android/network/repository/ApiRepository.dart';
import 'package:mti_android/network/response/listDataResponse.dart';
import 'package:sqflite/sqflite.dart';
import '../../../components/customSnackbar.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/SharedPreferences.dart';

class HomeController extends GetxController {
  final ApiRepository repository = Get.put(ApiRepository());
  var loading = false.obs;
  List<ListDataResponse>? listData = [];
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  Future<List<ListDataResponse>?> getListData(BuildContext context) async {
    listData?.clear();
    loading.value = true;
    var result = await repository.getListData();
    if (result != null) {
      print("Sukes Retrieve Data!");
      listData = result.map((e) => ListDataResponse(
          albumId: e.albumId,
          id: e.id,
          title: e.title,
          url: e.url,
      thumbnailUrl: e.thumbnailUrl))
          .toList();
      loading.value = false;
      print("list length ${listData?.length}");
      update();
      return listData;
    } else {
      loading.value = false;
      CustomSnackBar.show(context, "Gagal mendapatkan list pokemon", false);
      return null;
    }
  }

}
