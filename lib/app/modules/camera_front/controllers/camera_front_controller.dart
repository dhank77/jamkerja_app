import 'dart:io';

import 'package:absensisbc/app/function/alert.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class CameraFrontController extends GetxController {
  late CameraController cameraController;
  late List<CameraDescription> _cameras;

  Future<void> initCamera() async {
    _cameras = await availableCameras();
    print('cameras.length');
    print(_cameras.length);
    // if (cameras.length > 1) {
    //   cameraController = CameraController(cameras[1], ResolutionPreset.medium);
    // } else if (cameras.length == 1) {
    cameraController = CameraController(_cameras[0], ResolutionPreset.max);
    // } else {
    //   dialogError('Perangkat tidak didukung');
    // }
    await cameraController.initialize();
    // cameraController.initialize().then((_) {
    //   return;
    // }).catchError((Object e) {
    //   if (e is CameraException) {
    //     switch (e.code) {
    //       case 'CameraAccessDenied':
    //         // Handle access errors here.
    //         break;
    //       default:
    //         // Handle other errors here.
    //         break;
    //     }
    //   }
    // });
  }

  Future<File?> getPhoto() async {
    Directory root = await getTemporaryDirectory();
    String dirPath = '${root.path}/visit';
    await Directory(dirPath).create(recursive: true);
    String filePath = '$dirPath/${DateTime.now()}.jpg';

    try {
      await cameraController.takePicture();
    } catch (e) {
      print(e);
    }

    return File(filePath);
  }

  @override
  void onInit() {
    // initCamera();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // @override
  // void dispose() {
  //   cameraController.dispose();
  //   super.dispose();
  // }
}
