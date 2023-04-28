import 'package:get/get.dart';

import '../controllers/reimbursement_add_controller.dart';

class ReimbursementAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReimbursementAddController>(
      () => ReimbursementAddController(),
    );
  }
}
