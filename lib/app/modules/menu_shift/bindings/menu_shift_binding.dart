import 'package:get/get.dart';

import '../controllers/menu_shift_controller.dart';

class MenuShiftBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuShiftController>(
      () => MenuShiftController(),
    );
  }
}
