import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:absensisbc/app/component/app_bar.dart';
import 'package:absensisbc/app/component/card_pengumuman.dart';
import 'package:absensisbc/app/routes/app_pages.dart';

import '../controllers/pengumuman_controller.dart';

class PengumumanView extends GetView<PengumumanController> {
  const PengumumanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final PengumumanController controller = Get.put(PengumumanController());
    return Scaffold(
      appBar: const AppBarCustom(),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isDataProcessing.value == true) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                );
              } else {
                if (controller.listPengumuman.isNotEmpty) {
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 8, bottom: 8),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              'Pengumuman',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            controller: controller.scrollController,
                            itemCount: controller.listPengumuman.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (index ==
                                      controller.listPengumuman.length - 1 &&
                                  controller.isMoreDataAvailable.value ==
                                      true) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.green,
                                  ),
                                );
                              }
                              return Container(
                                child: CardPengumuman(
                                  imageUrl: controller.listPengumuman[index]
                                      ['file'],
                                  title: controller.listPengumuman[index]
                                      ['judul'],
                                  press: () => Get.toNamed(
                                    Routes.PENGUMUMAN_DETAIL,
                                    arguments: controller.listPengumuman[index],
                                  ),
                                  now: controller.dateToday ==
                                          controller.listPengumuman[index]
                                                  ['created_at']
                                              .toString()
                                      ? true
                                      : false,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      'Data tidak ditemukan',
                      style: TextStyle(fontSize: 25),
                    ),
                  );
                }
              }
            }),
          ),
        ],
      ),
    );
  }
}
