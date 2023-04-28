import 'package:absensisbc/app/component/camera_comp.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/camera_front_controller.dart';

class CameraFrontView extends GetView<CameraFrontController> {
  const CameraFrontView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('CameraFrontView'),
    //     centerTitle: true,
    //   ),
    //   backgroundColor: Colors.black,
    //   body: FutureBuilder(
    //     future: controller.initCamera(),
    //     builder: (context, snapshot) =>
    //         (snapshot.connectionState == ConnectionState.done)
    //             ? Container(
    //                 color: Colors.blue,
    //                 width: 300,
    //                 height: 300,
    //                 child: CameraPreview(controller.cameraController),
    //               )
    //             : const CircularProgressIndicator(),
    //   ),
    // );
    return const CameraComp();
  }
}
