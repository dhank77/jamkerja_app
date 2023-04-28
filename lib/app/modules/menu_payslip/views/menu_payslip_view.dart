import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:absensisbc/app/component/app_bar.dart';
import 'package:absensisbc/app/component/card_menu.dart';
import 'package:absensisbc/app/routes/app_pages.dart';

import '../controllers/menu_payslip_controller.dart';

class MenuPayslipView extends GetView<MenuPayslipController> {
  const MenuPayslipView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      body: Container(
        color: Colors.amber[50],
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Column(
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
                        'Payslip',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.amberAccent[500],
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              if (controller.isDataProcessing.value == true) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                );
              } else {
                if (controller.listData.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.listData.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == controller.listData.length - 1 &&
                            controller.isMoreDataAvailable.value == true) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.green,
                            ),
                          );
                        }
                        return CardMenu(
                          title: "Payslip",
                          color: "0xffe6ac00",
                          status: controller.listData[index]['Dis_aktif'] == "0"
                              ? "Tidak Aktif"
                              : "Aktif",
                          keterangan:
                              "Laporan Payslip  \n${controller.listData[index]['tanggal']}",
                          press: () => Get.toNamed(Routes.PAYSLIP_DETAIL,
                              arguments: controller.listData[index]),
                        );
                      },
                    ),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      'Data tidak ditemukan',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }
              }
            }),
          ],
        ),
      ),
    );
  }
}
