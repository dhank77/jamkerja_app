import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:absensisbc/app/component/app_bar.dart';
import 'package:absensisbc/app/component/child/navigation_bar_bottom.dart';

import '../controllers/presensi_laporan_controller.dart';
import 'package:intl/intl.dart';

class PresensiLaporanView extends GetView<PresensiLaporanController> {
  const PresensiLaporanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final PresensiLaporanController controller =
        Get.put(PresensiLaporanController());
    return Scaffold(
      appBar: const AppBarCustom(),
      body: RefreshIndicator(
        onRefresh: () => controller.refreshData(),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final picked = await showDateRangePicker(
                        context: context,
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData(
                              primarySwatch: Colors.grey,
                              splashColor: Colors.amber,
                              textTheme: const TextTheme(
                                subtitle1: TextStyle(color: Colors.amber),
                                button: TextStyle(color: Colors.amber),
                              ),
                              colorScheme: const ColorScheme.light(
                                  primary: Colors.amber,
                                  onSecondary: Colors.amber,
                                  onPrimary: Colors.white,
                                  surface: Colors.amber,
                                  onSurface: Colors.amber,
                                  secondary: Colors.amber),
                              dialogBackgroundColor: Colors.white,
                            ),
                            child: child ?? Text(""),
                          );
                        },
                        initialDateRange: DateTimeRange(
                          start: DateTime.parse(DateFormat('yyyy-MM-dd').format(
                              DateFormat('dd-MM-yyyy')
                                  .parse(controller.pickedStart.value))),
                          end: DateTime.parse(DateFormat('yyyy-MM-dd').format(
                              DateFormat('dd-MM-yyyy')
                                  .parse(controller.pickedEnd.value))),
                        ),
                        lastDate: DateTime.now(),
                        firstDate: DateTime(2021 - 01 - 01),
                      );
                      if (picked != null) {
                        controller.pickedStart.value = DateFormat('dd-MM-yyyy')
                            .format(picked.start)
                            .toString();
                        controller.pickedEnd.value = DateFormat('dd-MM-yyyy')
                            .format(picked.end)
                            .toString();
                        controller.getLaporan();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.amber,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Obx(
                            () => Text(
                              "${controller.pickedStart.value} - ${controller.pickedEnd.value}",
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
                  Obx(
                    () => Expanded(
                      child: ListView.builder(
                        // controller: controller.scrollController,
                        itemCount: controller.listData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 1),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                    width: double.infinity,
                                    alignment: AlignmentDirectional.center,
                                    child: Text(
                                      controller.listData[index]['tanggal'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                // Container(
                                //   height: 100,
                                //   width: double.infinity,
                                //   color: Colors.white,
                                //   child: Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceEvenly,
                                //     children: [
                                //       Expanded(
                                //         child: Container(
                                //           color: Colors.amber[50],
                                //           child: Column(
                                //             mainAxisAlignment:
                                //                 MainAxisAlignment.center,
                                //             children: [
                                //               const Text(
                                //                 'Presensi Masuk',
                                //                 style: TextStyle(
                                //                   fontSize: 12,
                                //                 ),
                                //               ),
                                //               Text(
                                //                 controller.listData[index]
                                //                     ['jam_datang'],
                                //                 style: const TextStyle(
                                //                   fontSize: 32,
                                //                   fontWeight: FontWeight.w900,
                                //                 ),
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                //       ),
                                //       Container(
                                //         height: double.infinity,
                                //         width: 2,
                                //         color: Colors.white,
                                //       ),
                                //       Container(
                                //         color: Colors.amber[50],
                                //         width: 50,
                                //         child: Column(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.center,
                                //           children: [
                                //             const Text(
                                //               'Istirahat',
                                //               style: TextStyle(
                                //                 fontSize: 10,
                                //               ),
                                //               textAlign: TextAlign.center,
                                //             ),
                                //             Text(
                                //               controller.listData[index]
                                //                       ['waktu_istirahat']
                                //                   .toString(),
                                //               style: const TextStyle(
                                //                 fontSize: 24,
                                //                 fontWeight: FontWeight.w900,
                                //               ),
                                //             ),
                                //             const Text(
                                //               'Menit',
                                //               style: TextStyle(
                                //                 fontSize: 10,
                                //               ),
                                //               textAlign: TextAlign.center,
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //       Container(
                                //         height: double.infinity,
                                //         width: 2,
                                //         color: Colors.white,
                                //       ),
                                //       Expanded(
                                //         child: Container(
                                //           color: Colors.amber[50],
                                //           child: Column(
                                //             mainAxisAlignment:
                                //                 MainAxisAlignment.center,
                                //             children: [
                                //               const Text(
                                //                 'Presensi Pulang',
                                //                 style: TextStyle(
                                //                   fontSize: 12,
                                //                 ),
                                //               ),
                                //               Text(
                                //                 controller.listData[index]
                                //                     ['jam_pulang'],
                                //                 style: const TextStyle(
                                //                   fontSize: 32,
                                //                   fontWeight: FontWeight.w900,
                                //                 ),
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                Container(
                                  height: 250,
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 160,
                                        color: Colors.amber[50],
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Presensi Datang',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              controller.listData[index]
                                                  ['jam_datang'],
                                              style: const TextStyle(
                                                fontSize: 32,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            const Text(
                                              'Istirahat Mulai',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              controller.listData[index]
                                                  ['jam_istirahat_mulai'],
                                              style: const TextStyle(
                                                fontSize: 32,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          color: Colors.amber[50],
                                          child: controller.listData[index]
                                                      ['image_datang'] !=
                                                  ''
                                              ? Image.network(
                                                  controller.listData[index]
                                                      ['image_datang'],
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  'assets/images/avatar.jpg',
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 250,
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          color: Colors.amber[50],
                                          child: controller.listData[index]
                                                      ['image_pulang'] !=
                                                  ''
                                              ? Image.network(
                                                  controller.listData[index]
                                                      ['image_pulang'],
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  'assets/images/avatar.jpg',
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                      Container(
                                        width: 160,
                                        color: Colors.amber[50],
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Presensi Pulang',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              controller.listData[index]
                                                  ['jam_pulang'],
                                              style: const TextStyle(
                                                fontSize: 32,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            const Text(
                                              'Istirahat Selesai',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              controller.listData[index]
                                                  ['jam_istirahat_selesai'],
                                              style: const TextStyle(
                                                fontSize: 32,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ],
                                        ),
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
          ],
        ),
      ),
    );
  }
}
