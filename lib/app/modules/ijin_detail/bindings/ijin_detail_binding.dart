import 'package:get/get.dart';

import '../controllers/ijin_detail_controller.dart';

class IjinDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IjinDetailController>(
      () => IjinDetailController(),
    );
  }
}
