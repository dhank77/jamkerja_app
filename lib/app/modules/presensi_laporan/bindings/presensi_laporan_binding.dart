import 'package:get/get.dart';

import '../controllers/presensi_laporan_controller.dart';

class PresensiLaporanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PresensiLaporanController>(
      () => PresensiLaporanController(),
    );
  }
}
