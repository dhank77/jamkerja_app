import 'package:get/get.dart';

import '../controllers/menu_presensi_controller.dart';

class MenuPresensiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuPresensiController>(
      () => MenuPresensiController(),
    );
  }
}
