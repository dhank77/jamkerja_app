import 'package:get/get.dart';

import '../controllers/camera_front_controller.dart';

class CameraFrontBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CameraFrontController>(
      () => CameraFrontController(),
    );
  }
}
