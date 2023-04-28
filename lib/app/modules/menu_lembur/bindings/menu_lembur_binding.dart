import 'package:get/get.dart';

import '../controllers/menu_lembur_controller.dart';

class MenuLemburBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuLemburController>(
      () => MenuLemburController(),
    );
  }
}
