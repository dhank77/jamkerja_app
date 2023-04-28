import 'package:get/get.dart';

import '../controllers/menu_perusahaan_controller.dart';

class MenuPerusahaanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuPerusahaanController>(
      () => MenuPerusahaanController(),
    );
  }
}
