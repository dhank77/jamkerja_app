import 'package:get/get.dart';

import '../controllers/cuti_add_controller.dart';

class CutiAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CutiAddController>(
      () => CutiAddController(),
    );
  }
}
