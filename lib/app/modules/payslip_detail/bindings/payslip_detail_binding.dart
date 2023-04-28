import 'package:get/get.dart';

import '../controllers/payslip_detail_controller.dart';

class PayslipDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PayslipDetailController>(
      () => PayslipDetailController(),
    );
  }
}
