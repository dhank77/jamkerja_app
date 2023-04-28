import 'package:get/get.dart';

import '../controllers/menu_cuti_controller.dart';

class MenuCutiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuCutiController>(
      () => MenuCutiController(),
    );
  }
}
