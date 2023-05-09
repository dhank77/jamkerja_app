import 'package:get/get.dart';

import '../controllers/presensi_lembur_controller.dart';

class PresensiLemburBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PresensiLemburController>(
      () => PresensiLemburController(),
    );
  }
}
