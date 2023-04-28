import 'package:get/get.dart';

import '../controllers/izin_detail_controller.dart';

class IzinDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IzinDetailController>(
      () => IzinDetailController(),
    );
  }
}
