import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mti_android/network/api/Api.dart';
import 'package:mti_android/network/response/listDataResponse.dart';

class ApiRepository {
  final Api remoteSource = Api();

  Future<List<ListDataResponse>?> getListData() async {
    try {
      List<ListDataResponse> listDataResponse;
      var res = await remoteSource.getListData();
      print("res = ${res}");
      if (res.statusCode == 200) {
        var jsonEncode = json.encode(res.data);
        List jsonResponse = json.decode(jsonEncode);
        listDataResponse = jsonResponse.map((data)=>ListDataResponse.fromJson(data)).toList();

        // print("pokemon detail response = ${pokemonListResponse}");
        return listDataResponse;
      } else {
        return null;
      }
    } on DioError catch (e) {
      print("dio error: $e");
    }
  }

}
