import 'package:get/get.dart';

import '../controllers/menu_payslip_controller.dart';

class MenuPayslipBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuPayslipController>(
      () => MenuPayslipController(),
    );
  }
}
