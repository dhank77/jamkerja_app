import 'package:get/get.dart';

import '../controllers/menu_visit_controller.dart';

class MenuVisitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuVisitController>(
      () => MenuVisitController(),
    );
  }
}
