import 'package:get/get.dart';

import '../controllers/lembur_add_controller.dart';

class LemburAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LemburAddController>(
      () => LemburAddController(),
    );
  }
}
