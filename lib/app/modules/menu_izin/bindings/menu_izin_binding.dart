import 'package:get/get.dart';

import '../controllers/menu_izin_controller.dart';

class MenuIzinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuIzinController>(
      () => MenuIzinController(),
    );
  }
}
