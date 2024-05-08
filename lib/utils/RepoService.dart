import 'package:get/get.dart';
import 'package:mti_android/network/api/Api.dart';

class RepoService extends GetxService {
  @override
  void onInit() {
    // TODO: implement onInit
    initRepo();
    super.onInit();
  }

  void initRepo() {
    Get.lazyPut(() => Api());
  }
}
