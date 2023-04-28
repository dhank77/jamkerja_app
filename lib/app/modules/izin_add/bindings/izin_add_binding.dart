import 'package:get/get.dart';

import '../controllers/izin_add_controller.dart';

class IzinAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IzinAddController>(
      () => IzinAddController(),
    );
  }
}
