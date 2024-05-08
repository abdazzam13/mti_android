import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../components/itemImage.dart';
import '../../../../utils/helper.dart';
import '../../controller/HomeController.dart';

class ListDataScreen extends StatefulWidget {
  const ListDataScreen({super.key});

  @override
  State<ListDataScreen> createState() => _ListDataScreenState();
}

class _ListDataScreenState extends State<ListDataScreen> {
  final HomeController homeController = Get.find();
  var isInternet = false.obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("ini initstate list data");
    homeController.getListData(context);
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
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          controller.listData?.length != 0
                              ? Expanded(
                            child: ListView.builder(
                              itemCount: controller.listData?.length,
                              itemBuilder: (context, index) => itemImage(context: context, listData: controller.listData![index]),
                            ),
                          )
                              : Center(
                            child: Text("List data kosong"),
                          ),
                        ],
                      ),
                    ),
                  )
                ),
                onRefresh: () async {
                  homeController.getListData(context);
                });
          }
        }));
  }

}
