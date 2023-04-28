import 'package:get/get.dart';

import '../controllers/sakit_add_controller.dart';

class SakitAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SakitAddController>(
      () => SakitAddController(),
    );
  }
}
