import 'package:get/get.dart';

import '../controllers/menu_sakit_controller.dart';

class MenuSakitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuSakitController>(
      () => MenuSakitController(),
    );
  }
}
