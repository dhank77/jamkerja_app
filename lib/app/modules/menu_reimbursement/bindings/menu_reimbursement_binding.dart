import 'package:get/get.dart';

import '../controllers/menu_reimbursement_controller.dart';

class MenuReimbursementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuReimbursementController>(
      () => MenuReimbursementController(),
    );
  }
}
