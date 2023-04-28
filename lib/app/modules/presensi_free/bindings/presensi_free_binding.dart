import 'package:get/get.dart';

import '../controllers/presensi_free_controller.dart';

class PresensiFreeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PresensiFreeController>(
      () => PresensiFreeController(),
    );
  }
}
