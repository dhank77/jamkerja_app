import 'package:get/get.dart';

import '../controllers/cuti_detail_controller.dart';

class CutiDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CutiDetailController>(
      () => CutiDetailController(),
    );
  }
}
