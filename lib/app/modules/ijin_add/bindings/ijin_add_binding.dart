import 'package:get/get.dart';

import '../controllers/ijin_add_controller.dart';

class IjinAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IjinAddController>(
      () => IjinAddController(),
    );
  }
}
