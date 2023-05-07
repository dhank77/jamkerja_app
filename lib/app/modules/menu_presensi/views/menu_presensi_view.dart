import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jamkerja/app/component/app_bar.dart';
import 'package:jamkerja/app/component/card_stats.dart';

import '../controllers/menu_presensi_controller.dart';

class MenuPresensiView extends GetView<MenuPresensiController> {
  const MenuPresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      body: Container(
        color: Colors.amber[50],
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: ClipPathClass(),
                    child: Container(
                      height: 230,
                      width: Get.width,
                      color: Colors.amber[600],
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.center,
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "${controller.dateTime.value.hour.toString().padLeft(2, '0')}:${controller.dateTime.value.minute.toString().padLeft(2, '0')}:${controller.dateTime.value.second.toString().padLeft(2, '0')}",
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Tahoma',
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${controller.dateTime.value.day.toString().padLeft(2, '0')} - ${controller.dateTime.value.month.toString().padLeft(2, '0')} - ${controller.dateTime.value.year.toString()}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Tahoma',
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 120),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Card(
                        elevation: 8,
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.location_searching,
                                size: 40,
                                color: Colors.amber,
                              ),
                              title: const Text('Data Lokasi'),
                              subtitle: Obx(
                                () => Text(
                                  controller.longlat.value,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 16.0, left: 16.0),
                              child: Obx(
                                () => Text(
                                  'Alamat : \n' + controller.alamat.value,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(
                    () => controller.animate.isFalse
                        ? ElevatedButton(
                            onPressed: () => controller.presensi(),
                            style: ElevatedButton.styleFrom(
                              primary: controller.shiftStatus.isTrue
                                  ? Colors.amber[500]
                                  : Colors.grey[300],
                              fixedSize: const Size(150, 50),
                            ),
                            child: Text(controller.tombol_text.value),
                          )
                        : ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: controller.shiftStatus.isTrue
                                  ? Colors.amber[500]
                                  : Colors.grey[300],
                              fixedSize: const Size(150, 50),
                            ),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                  ),
                  ElevatedButton(
                    onPressed: () => controller.updatePosition(),
                    child: Text("Sesuaikan Lokasi"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber[500],
                      fixedSize: Size(150, 50),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                height: 5,
                width: Get.width,
                color: Colors.grey.withOpacity(0.2),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Statistik Hari ini",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                    child: Obx(
                  () => Column(
                    children: [
                      CardStats(
                        title: 'Datang',
                        value: controller.hariData['waktu_datang'].toString(),
                        icon: Icons.event_available_rounded,
                      ),
                      CardStats(
                        title: 'Istirahat',
                        value:
                            controller.hariData['waktu_istirahat'].toString(),
                        icon: Icons.restaurant_menu_rounded,
                      ),
                      CardStats(
                        title: 'Pulang',
                        value: controller.hariData['waktu_pulang'].toString(),
                        icon: Icons.restore,
                      ),
                    ],
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 60,
    );
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
