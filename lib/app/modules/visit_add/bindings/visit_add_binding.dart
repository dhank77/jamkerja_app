import 'package:get/get.dart';

import '../controllers/visit_add_controller.dart';

class VisitAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisitAddController>(
      () => VisitAddController(),
    );
  }
}
