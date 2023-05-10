import 'dart:io';

import 'package:jamkerja/app/component/app_bar.dart';
import 'package:jamkerja/app/component/button_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/presensi_lembur_controller.dart';

class PresensiLemburView extends GetView<PresensiLemburController> {
  const PresensiLemburView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      body: Column(
        children: [
          SizedBox(
            height: 350,
            child: Stack(
              children: [
                Obx(
                  () => GoogleMap(
                    onMapCreated: (GoogleMapController ctr) {
                      if (!controller.ctrmaps.isCompleted) {
                        controller.ctrmaps.complete(ctr);
                      }
                    },
                    zoomControlsEnabled: false,
                    mapType: MapType.normal,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(-7.688264, 112.273356),
                      zoom: 18.0,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId(
                            "${controller.lat.value}, ${controller.long.value}"),
                        position:
                            LatLng(controller.lat.value, controller.long.value),
                        icon: BitmapDescriptor.defaultMarker,
                      ),
                    },
                  ),
                ),
                Obx(
                  () =>
                      Text("${controller.lat.value}, ${controller.long.value}"),
                ),
                (Platform.isAndroid)
                    ? Positioned(
                        bottom: 3,
                        right: -2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            child: ElevatedButton(
                              onPressed: () => controller.getCurrentLocation(),
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(15),
                                primary: Colors.blue,
                              ),
                              child: const Icon(Icons.location_searching),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: Obx(
                  () => controller.lembur.value == true
                      ? Column(
                          children: [
                            Container(
                              alignment: AlignmentDirectional.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${controller.dateTime.value.hour.toString().padLeft(2, '0')}:${controller.dateTime.value.minute.toString().padLeft(2, '0')}:${controller.dateTime.value.second.toString().padLeft(2, '0')}",
                                    style: const TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Tahoma',
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "${controller.dateTime.value.day.toString().padLeft(2, '0')} - ${controller.dateTime.value.month.toString().padLeft(2, '0')} - ${controller.dateTime.value.year.toString()}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Tahoma',
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ButtonCard(
                                  press: () => controller.checkInOut('masuk'),
                                  icon: Icons.location_history,
                                  judul: "Check In Lembur",
                                  animate: controller.animate1.value,
                                ),
                                ButtonCard(
                                  press: () => controller.checkInOut('keluar'),
                                  icon: Icons.wrong_location_rounded,
                                  judul: "Check Out Lembur",
                                  animate: controller.animate2.value,
                                ),
                              ],
                            ),
                          ],
                        )
                      : Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                'Waktu Lembur dibuka 1 Jam Sebelum Waktu Mulai dan ditutup 1 Jam Setelah Waktu Selesai',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
