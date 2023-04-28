import 'package:get/get.dart';

import '../controllers/pengumuman_detail_controller.dart';

class PengumumanDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengumumanDetailController>(
      () => PengumumanDetailController(),
    );
  }
}
