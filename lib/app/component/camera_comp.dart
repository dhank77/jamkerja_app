
import 'package:jamkerja/app/component/app_bar.dart';
import 'package:jamkerja/app/function/alert.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class CameraComp extends StatefulWidget {
  const CameraComp({super.key});

  @override
  State<CameraComp> createState() => _CameraCompState();
}

class _CameraCompState extends State<CameraComp> {
  late CameraController cameraController;
  late List<CameraDescription> _cameras;

  Future<void> initCamera() async {
    _cameras = await availableCameras();
    if (_cameras.length > 1) {
      cameraController = CameraController(_cameras[1], ResolutionPreset.medium);
    } else if (_cameras.length == 1) {
      cameraController = CameraController(_cameras[0], ResolutionPreset.medium);
    } else {
      dialogError('Perangkat tidak didukung');
    }
    await cameraController.initialize();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  Future<XFile?> getPhoto() async {
    // Directory root = await getApplicationDocumentsDirectory();
    // String dirPath = '${root.path}/visit';
    // await Directory(dirPath).create(recursive: true);
    // String filePath = '$dirPath/${DateTime.now()}.jpg';

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } catch (e) {
      print(e);
      return null;
    }

    // return File(filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: initCamera(),
        builder: (context, snapshot) =>
            (snapshot.connectionState == ConnectionState.done)
                ? Column(
                    children: [
                      Container(
                        color: Colors.blue,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: CameraPreview(cameraController),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () async {
                            if (!cameraController.value.isTakingPicture) {
                              XFile? result = await getPhoto();
                              Get.back(result: result);
                            }
                          },
                          icon: const Icon(
                            Icons.camera,
                            color: Colors.amber,
                            size: 50,
                          ),
                          alignment: Alignment.center,
                        ),
                      )
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  ),
      ),
    );
  }
}
