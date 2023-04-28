import 'package:get/get.dart';

import '../controllers/sakit_detail_controller.dart';

class SakitDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SakitDetailController>(
      () => SakitDetailController(),
    );
  }
}
