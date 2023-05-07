import 'dart:io';

import 'package:jamkerja/app/component/app_bar.dart';
import 'package:jamkerja/app/component/button_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/presensi_free_controller.dart';

class PresensiFreeView extends GetView<PresensiFreeController> {
  const PresensiFreeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      body: Column(
        children: [
          Container(
            height: 200,
            padding: const EdgeInsets.all(10.0),
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
                  () => Column(
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
                            press: () => controller.checkIn(),
                            icon: Icons.location_history,
                            judul: "Check In",
                            animate: controller.animate1.value,
                          ),
                          ButtonCard(
                            press: () => controller.checkOut(),
                            icon: Icons.wrong_location_rounded,
                            judul: "Check Out",
                            animate: controller.animate2.value,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ButtonCard(
                            press: () => controller.istirahatMulai(),
                            icon: Icons.free_breakfast,
                            judul: "Break",
                            animate: controller.animate3.value,
                          ),
                          ButtonCard(
                            press: () => controller.istirahatSelesai(),
                            icon: Icons.breakfast_dining,
                            judul: "After Break",
                            animate: controller.animate4.value,
                          ),
                        ],
                      ),
                    ],
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
