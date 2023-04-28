import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PengumumanDetailController extends GetxController {
  var dataUser = GetStorage().read('dataUser');
  var data = Get.arguments;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
