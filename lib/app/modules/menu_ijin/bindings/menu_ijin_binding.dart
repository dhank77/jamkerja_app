import 'package:get/get.dart';

import '../controllers/menu_ijin_controller.dart';

class MenuIjinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuIjinController>(
      () => MenuIjinController(),
    );
  }
}
