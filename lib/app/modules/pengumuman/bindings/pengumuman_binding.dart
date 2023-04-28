import 'package:get/get.dart';

import '../controllers/pengumuman_controller.dart';

class PengumumanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengumumanController>(
      () => PengumumanController(),
    );
  }
}
