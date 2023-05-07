// ignore_for_file: unrelated_type_equality_checks

import 'package:jamkerja/app/component/card_summary.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jamkerja/app/component/banner.dart';
import 'package:jamkerja/app/component/child/navigation_bar_bottom.dart';
import 'package:jamkerja/app/component/item_kategori.dart';
import 'package:jamkerja/app/component/navigation.dart';
import 'package:jamkerja/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Container(
          alignment: Alignment.centerLeft,
          height: 40,
          child: Row(
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: Image.asset("assets/images/logo.png"),
              ),
              const Text(
                ' JamKerja.ID',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => controller.logout(),
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              width: 30,
              height: 30,
              child: const Icon(Icons.logout),
            ),
          ),
        ],
        backgroundColor: Colors.amber[600],
        elevation: 0,
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper: ClipPathClass(),
            child: Container(
              height: 120,
              width: Get.width,
              color: Colors.amber[600],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () => () {},
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 2, top: 2, right: 2, bottom: 2),
                      alignment: AlignmentDirectional.center,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 50,
                          child: ClipOval(
                            child: controller.dataUser['images'] != ""
                                ? Image.network(controller.dataUser['images'])
                                : Image.asset("assets/images/profile_logo.png"),
                          ),
                        ),
                        title: const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Selamat Datang, ',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.dataUser['name'] +
                                    '\n' +
                                    controller.dataUser['jabatan'].toString() +
                                    '\n' +
                                    controller.dataUser['skpd'].toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white60,
                          child: ListView(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    const Text(
                                      "Layanan Kami",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ItemKategori(
                                          title: "Presensi",
                                          color: const Color(0xff5369f8),
                                          icon: Icons.location_on,
                                          tap: () => Get.toNamed(
                                            Routes.PRESENSI_FREE,
                                          ),
                                        ),
                                        ItemKategori(
                                          title: "Kunjungan",
                                          color: const Color(0xffec1d27),
                                          icon: Icons.share_location_sharp,
                                          tap: () => Get.toNamed(
                                            Routes.MENU_VISIT,
                                          ),
                                        ),
                                        ItemKategori(
                                          title: "Lembur",
                                          color: const Color(0xff0b945e),
                                          icon: Icons.timelapse_sharp,
                                          tap: () => Get.toNamed(
                                            Routes.MENU_LEMBUR,
                                          ),
                                        ),
                                        ItemKategori(
                                          title: "Jam Kerja",
                                          color: const Color(0xff72d2a2),
                                          icon: Icons.lock_clock,
                                          tap: () =>
                                              Get.toNamed(Routes.JAM_KERJA),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ItemKategori(
                                          title: "Cuti",
                                          color: const Color(0xff68a9e3),
                                          icon: Icons.timer_sharp,
                                          tap: () => Get.toNamed(
                                            Routes.MENU_CUTI,
                                          ),
                                        ),
                                        ItemKategori(
                                          title: "Sakit",
                                          color: Colors.lightBlueAccent,
                                          icon: Icons.sticky_note_2,
                                          tap: () => Get.toNamed(
                                            Routes.MENU_SAKIT,
                                          ),
                                        ),
                                        ItemKategori(
                                          title: "Izin",
                                          color: const Color(0xff72d2a2),
                                          icon: Icons.note_alt_sharp,
                                          tap: () =>
                                              Get.toNamed(Routes.MENU_IZIN),
                                        ),
                                        ItemKategori(
                                          title: "Ijin",
                                          color: const Color(0xffF4BB44),
                                          icon: Icons
                                              .system_security_update_warning_sharp,
                                          tap: () =>
                                              Get.toNamed(Routes.MENU_IJIN),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ItemKategori(
                                          title: "Reimbur\nsement",
                                          color: const Color(0xff14639e),
                                          icon: Icons.receipt_long_outlined,
                                          tap: () => Get.toNamed(
                                            Routes.MENU_REIMBURSEMENT,
                                          ),
                                        ),
                                        ItemKategori(
                                          title: "Payslip",
                                          color: Colors.amber,
                                          icon: Icons.library_books_outlined,
                                          tap: () =>
                                              Get.toNamed(Routes.MENU_PAYSLIP),
                                        ),
                                        ItemKategori(
                                          title: "Perusahaan",
                                          color: const Color(0xff8dc53e),
                                          icon: Icons.corporate_fare,
                                          tap: () => Get.toNamed(
                                            Routes.MENU_PERUSAHAAN,
                                          ),
                                        ),
                                        const SizedBox(width: 60),
                                      ],
                                    ),
                                    const SizedBox(height: 30),
                                  ],
                                ),
                              ),
                              Container(
                                height: 6,
                                width: Get.width,
                                color: Colors.grey.withOpacity(0.2),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Obx(
                                    () => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Kehadiran",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              controller.kehadiran.toString() !=
                                                      "{}"
                                                  ? controller
                                                      .kehadiran['periode']
                                                  : "",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CardSummary(
                                              title: "Hadir",
                                              icon: Icons.location_history,
                                              value: controller
                                                  .kehadiran['kehadiran']
                                                  .toString(),
                                              color: const Color(0xff5369f8),
                                              width: Get.width * 0.27,
                                            ),
                                            CardSummary(
                                              title: "Terlambat",
                                              icon: Icons.lock_clock_rounded,
                                              value: controller
                                                  .kehadiran['total_telat']
                                                  .toString(),
                                              color: const Color(0xff5369f8),
                                              width: Get.width * 0.27,
                                            ),
                                            CardSummary(
                                              title: "Pulang Cepat",
                                              icon: Icons.punch_clock_rounded,
                                              value: controller
                                                  .kehadiran['pulang_cepat']
                                                  .toString(),
                                              color: const Color(0xff5369f8),
                                              width: Get.width * 0.27,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 15),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CardSummary(
                                              width: Get.width * 0.20,
                                              fontSize: 8,
                                              title: "Tidak Ceklok Masuk",
                                              icon:
                                                  Icons.arrow_circle_down_sharp,
                                              value: controller.kehadiran['tcm']
                                                  .toString(),
                                              color: const Color(0xffec1d27),
                                            ),
                                            CardSummary(
                                              width: Get.width * 0.20,
                                              fontSize: 8,
                                              title: "Tidak Ceklok Pulang",
                                              icon: Icons.arrow_circle_up_sharp,
                                              value: controller.kehadiran['tcp']
                                                  .toString(),
                                              color: const Color(0xffec1d27),
                                            ),
                                            CardSummary(
                                              width: Get.width * 0.20,
                                              fontSize: 8,
                                              title: "Tidak Ceklok Break",
                                              icon: Icons
                                                  .arrow_circle_right_outlined,
                                              value: controller.kehadiran['tcb']
                                                  .toString(),
                                              color: const Color(0xffec1d27),
                                            ),
                                            CardSummary(
                                              width: Get.width * 0.20,
                                              fontSize: 8,
                                              title: "Tidak Ceklok After Break",
                                              icon: Icons
                                                  .arrow_circle_left_outlined,
                                              value: controller
                                                  .kehadiran['tcab']
                                                  .toString(),
                                              color: const Color(0xffec1d27),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 15),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CardSummary(
                                              width: Get.width * 0.20,
                                              title: "Cuti",
                                              icon: Icons
                                                  .document_scanner_rounded,
                                              value: controller
                                                  .kehadiran['cuti']
                                                  .toString(),
                                              color: const Color.fromARGB(
                                                  255, 43, 174, 54),
                                            ),
                                            CardSummary(
                                              width: Get.width * 0.20,
                                              title: "Sakit",
                                              icon: Icons.sick_sharp,
                                              value: controller
                                                  .kehadiran['sakit']
                                                  .toString(),
                                              color: const Color.fromARGB(
                                                  255, 43, 174, 54),
                                            ),
                                            CardSummary(
                                              width: Get.width * 0.20,
                                              title: "Izin",
                                              icon: Icons.report,
                                              value: controller
                                                  .kehadiran['izin']
                                                  .toString(),
                                              color: const Color.fromARGB(
                                                  255, 43, 174, 54),
                                            ),
                                            CardSummary(
                                              width: Get.width * 0.20,
                                              title: "Ijin",
                                              icon: Icons.restore_page_sharp,
                                              value: controller
                                                  .kehadiran['ijin']
                                                  .toString(),
                                              color: const Color.fromARGB(
                                                  255, 43, 174, 54),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 6,
                                width: Get.width,
                                color: Colors.grey.withOpacity(0.2),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 30),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Pengumuman",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () =>
                                              Get.toNamed(Routes.PENGUMUMAN),
                                          child: const Text(
                                            "Lihat Semua",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Obx(
                                        () => Row(
                                          children: controller.listPengumuman
                                              .map(
                                                (item) => BannerPage(
                                                  image:
                                                      item['file'].toString(),
                                                  tap: () => Get.toNamed(
                                                    Routes.PENGUMUMAN_DETAIL,
                                                    arguments: item,
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      // Navigation
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class StatusCard extends StatelessWidget {
  const StatusCard({
    Key? key,
    required this.title,
    required this.data,
    required this.satuan,
  }) : super(key: key);

  final String title;
  final String data;
  final String satuan;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        width: Get.width * 0.25,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            RichText(
              text: TextSpan(
                text: data,
                style: const TextStyle(
                  fontSize: 22,
                  color: Color(0xFFEC2028),
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: " $satuan",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF747D8C),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClipInfoClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width - 80, size.height);
    path.lineTo(size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
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
