import 'package:get/get.dart';

import '../controllers/reimbursement_detail_controller.dart';

class ReimbursementDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReimbursementDetailController>(
      () => ReimbursementDetailController(),
    );
  }
}
