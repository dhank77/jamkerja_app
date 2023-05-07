import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jamkerja/app/routes/app_pages.dart';

class ProfilController extends GetxController {
  var dataUser = GetStorage().read('dataUser');
  final animate = false.obs;
  final animateData = false.obs;

  void logout() {
    animate.value = true;
    GetStorage().remove('dataPegawai');
    Get.offAllNamed(Routes.AUTH_LOGIN);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
