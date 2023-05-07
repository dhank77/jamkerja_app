// ignore_for_file: unrelated_type_equality_checks

import 'package:jamkerja/app/component/card_stats.dart';
import 'package:jamkerja/app/component/card_summary.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jamkerja/app/component/app_bar.dart';
import 'package:jamkerja/app/component/card_menu.dart';
import 'package:jamkerja/app/routes/app_pages.dart';

import '../controllers/menu_cuti_controller.dart';

class MenuCutiView extends GetView<MenuCutiController> {
  const MenuCutiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      body: Container(
        color: Colors.amber[50],
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Obx(
          () => Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          'Pengajuan Cuti',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.amberAccent[500],
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.CUTI_ADD),
                      child: Column(
                        children: [
                          Container(
                            child: const Icon(
                              Icons.add_circle,
                              size: 28,
                              color: Colors.amber,
                            ),
                          ),
                          const Text(
                            'TAMBAH',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardSummary(
                    title: 'Total Cuti',
                    value: controller.cuti != ""
                        ? controller.cuti['jatah'].toString()
                        : "0",
                    color: const Color.fromARGB(255, 38, 175, 95),
                    icon: Icons.calendar_month,
                  ),
                  CardSummary(
                    title: 'Telah Cuti',
                    value: controller.cuti != ""
                        ? controller.cuti['terpakai'].toString()
                        : "0",
                    color: const Color.fromARGB(255, 38, 175, 95),
                    icon: Icons.date_range,
                  ),
                  CardSummary(
                    title: 'Sisa Cuti',
                    value: controller.cuti != ""
                        ? controller.cuti['sisa'].toString()
                        : "0",
                    color: const Color.fromARGB(255, 38, 175, 95),
                    icon: Icons.calculate_rounded,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              controller.isDataProcessing.value == true
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    )
                  : ((controller.listData.isNotEmpty)
                      ? Expanded(
                          child: ListView.builder(
                            controller: controller.scrollController,
                            itemCount: controller.listData.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == controller.listData.length - 1 &&
                                  controller.isMoreDataAvailable.value ==
                                      true) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.green,
                                  ),
                                );
                              }
                              return CardMenu(
                                title: controller.listData[index]['cuti'],
                                status: controller.listData[index]['status'],
                                keterangan:
                                    "Pengajuan ${controller.listData[index]['cuti']} \n${controller.listData[index]['tanggal_mulai']} - ${controller.listData[index]['tanggal_selesai']}",
                                press: () => Get.toNamed(
                                  Routes.CUTI_DETAIL,
                                  arguments: controller.listData[index],
                                ),
                              );
                            },
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Text(
                            'Data tidak ditemukan',
                            style: TextStyle(fontSize: 20),
                          ),
                        ))
            ],
          ),
        ),
      ),
    );
  }
}
