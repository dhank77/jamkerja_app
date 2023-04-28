import 'package:get/get.dart';

import '../controllers/shift_add_controller.dart';

class ShiftAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShiftAddController>(
      () => ShiftAddController(),
    );
  }
}
