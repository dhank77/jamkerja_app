import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jamkerja/app/component/app_bar.dart';
import 'package:jamkerja/app/routes/app_pages.dart';

import '../controllers/menu_visit_controller.dart';
import 'package:intl/intl.dart';

class MenuVisitView extends GetView<MenuVisitController> {
  const MenuVisitView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      body: Container(
        color: Colors.blue[50],
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Obx(
          () => controller.isDataProcessing.isFalse
              ? Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                'Kunjungan Lokasi',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blueAccent[500],
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed(Routes.VISIT_ADD),
                            child: Column(
                              children: [
                                Container(
                                  child: const Icon(
                                    Icons.add,
                                    size: 28,
                                    color: Colors.blue,
                                  ),
                                ),
                                const Text(
                                  'Kunjungan',
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
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: GestureDetector(
                                onTap: () async {
                                  final picked = await showDateRangePicker(
                                    context: context,
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return Theme(
                                        data: ThemeData(
                                          primarySwatch: Colors.grey,
                                          splashColor: Colors.blue,
                                          textTheme: const TextTheme(
                                            subtitle1:
                                                TextStyle(color: Colors.blue),
                                            button:
                                                TextStyle(color: Colors.blue),
                                          ),
                                          colorScheme: const ColorScheme.light(
                                              primary: Colors.blue,
                                              onSecondary: Colors.blue,
                                              onPrimary: Colors.white,
                                              surface: Colors.blue,
                                              onSurface: Colors.blue,
                                              secondary: Colors.blue),
                                          dialogBackgroundColor: Colors.white,
                                        ),
                                        child: child ?? Text(""),
                                      );
                                    },
                                    initialDateRange: DateTimeRange(
                                      start: DateTime.parse(
                                          DateFormat('yyyy-MM-dd').format(
                                              DateFormat('dd-MM-yyyy').parse(
                                                  controller
                                                      .pickedStart.value))),
                                      end: DateTime.parse(
                                          DateFormat('yyyy-MM-dd').format(
                                              DateFormat('dd-MM-yyyy').parse(
                                                  controller.pickedEnd.value))),
                                    ),
                                    lastDate: DateTime.now(),
                                    firstDate: DateTime(2021 - 01 - 01),
                                  );
                                  if (picked != null) {
                                    controller.pickedStart.value =
                                        DateFormat('dd-MM-yyyy')
                                            .format(picked.start)
                                            .toString();
                                    controller.pickedEnd.value =
                                        DateFormat('dd-MM-yyyy')
                                            .format(picked.end)
                                            .toString();
                                    controller.getData();
                                  }
                                },
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          color: Colors.blue,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Obx(
                                          () => Text(
                                            controller.pickedStart.value +
                                                " - " +
                                                controller.pickedEnd.value,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Obx(
                              () => Expanded(
                                child: ListView.builder(
                                  itemCount: controller.listData.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 1),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Container(
                                              width: double.infinity,
                                              alignment:
                                                  AlignmentDirectional.center,
                                              child: Text(
                                                controller.listData[index]
                                                    ['tanggal'],
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 100,
                                            width: double.infinity,
                                            color: Colors.white,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    color: Colors.blue[100],
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          controller.listData[
                                                              index]['judul'],
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                          ),
                                                        ),
                                                        Text(
                                                          controller.listData[
                                                                  index]
                                                              ['keterangan'],
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        Text(
                                                          controller.listData[
                                                                  index]
                                                              ['kordinat'],
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        Text(
                                                          controller.listData[
                                                              index]['lokasi'],
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: double.infinity,
                                                  width: 2,
                                                  color: Colors.white,
                                                ),
                                                Container(
                                                  width: 100,
                                                  color: Colors.blue[100],
                                                  child: Image.network(
                                                      controller.listData[index]
                                                          ['foto']),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
        ),
      ),
    );
  }
}
