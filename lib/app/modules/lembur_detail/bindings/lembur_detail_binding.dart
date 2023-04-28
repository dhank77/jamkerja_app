import 'package:get/get.dart';

import '../controllers/lembur_detail_controller.dart';

class LemburDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LemburDetailController>(
      () => LemburDetailController(),
    );
  }
}
