import 'package:jamkerja/app/component/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/jam_kerja_controller.dart';

class JamKerjaView extends GetView<JamKerjaController> {
  const JamKerjaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      body: Obx(
        () => controller.jamKerja['keterangan'] == "statis"
            ? Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                      child: Text(
                        controller.jamKerja['kode_jam_kerja'] +
                            " - " +
                            controller.jamKerja['nama'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: controller.listDataStatis
                              .map(
                                (dt) => Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.blue,
                                          ),
                                          padding: const EdgeInsets.all(8),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          "Hari : " + dt['hari'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.red,
                                          ),
                                          padding: const EdgeInsets.all(8),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          "Waktu kerja : " +
                                              dt['jam_datang'] +
                                              " - " +
                                              dt['jam_pulang'],
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.green,
                                          ),
                                          padding: const EdgeInsets.all(8),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          "Waktu Istirahat : " +
                                              dt['istirahat'].toString(),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.blue,
                                          ),
                                          padding: const EdgeInsets.all(8),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          "Toleransi Terlambat : " +
                                              dt['toleransi_datang'].toString(),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.blue,
                                          ),
                                          padding: const EdgeInsets.all(8),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          "Toleransi Cepat Pulang : " +
                                              dt['toleransi_pulang'].toString(),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 30),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => controller.changeMonthMin(),
                        child: const Icon(
                          Icons.arrow_circle_left,
                          size: 26,
                          color: Color.fromARGB(255, 115, 90, 0),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          DateFormat("MMMM yyyy").format(DateTime(
                              controller.tahun.value,
                              controller.bulan.value,
                              1)),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => controller.changeMonthPlus(),
                        child: const Icon(
                          Icons.arrow_circle_right,
                          size: 26,
                          color: Color.fromARGB(255, 115, 90, 0),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: controller.listData
                        .map(
                          (item) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: (item as List<dynamic>)
                                .map(
                                  (row) => Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color:
                                            Color(int.parse(row['color_kode'])),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 3,
                                        horizontal: 5,
                                      ),
                                      alignment: AlignmentDirectional.center,
                                      child: Text(
                                        row['tanggal_saja'],
                                        style: TextStyle(
                                          color: Color(int.parse(row['color'])),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          // (item) => Text(item.toString()),
                        )
                        .toList(),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 25, left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Keterangan :"),
                          const SizedBox(height: 10),
                          Column(
                            children: controller.listMaster
                                .map(
                                  (e) => Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Color(
                                                int.parse(e['color_code'])),
                                          ),
                                          padding: const EdgeInsets.all(8),
                                        ),
                                        const SizedBox(width: 10),
                                        e['nama'] == "Libur"
                                            ? const Text(
                                                "Libur / Cuti",
                                              )
                                            : Text(
                                                e['nama'] +
                                                    " : " +
                                                    e['jam_datang'] +
                                                    " - " +
                                                    e['jam_pulang'],
                                              )
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
