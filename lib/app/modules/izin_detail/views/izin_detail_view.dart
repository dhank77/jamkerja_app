import 'package:jamkerja/app/component/app_bar.dart';
import 'package:jamkerja/app/component/child/status.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/izin_detail_controller.dart';

class IzinDetailView extends GetView<IzinDetailController> {
  const IzinDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      body: Container(
        color: Colors.amber[50],
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                'Pengajuan Izin',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    DataTable(
                      columns: <DataColumn>[
                        const DataColumn(
                          label: Text(
                            'Izin',
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            controller.data["izin"],
                          ),
                        ),
                      ],
                      rows: <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            const DataCell(
                              Text(
                                'Mulai',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            DataCell(
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child:
                                    Text(controller.data["tanggal_mulai_api"]),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            const DataCell(
                              Text(
                                'Selesai',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            DataCell(
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text(
                                    controller.data["tanggal_selesai_api"]),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            const DataCell(
                              Text(
                                'Status',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            DataCell(
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Status(
                                    status: controller.data['status_api']),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 1,
                      width: Get.width,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 10, top: 5, right: 25),
                      child: Column(
                        children: [
                          Container(
                            alignment: AlignmentDirectional.topStart,
                            margin: const EdgeInsets.only(bottom: 10, top: 15),
                            child: const Text(
                              'Keterangan : ',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            alignment: AlignmentDirectional.topStart,
                            child: Text(
                              controller.data['keterangan'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    controller.data["komentar"].toString() != ""
                        ? Container(
                            padding: const EdgeInsets.only(
                                left: 10, top: 5, right: 25),
                            child: Column(
                              children: [
                                Container(
                                  alignment: AlignmentDirectional.topStart,
                                  margin: const EdgeInsets.only(
                                      bottom: 10, top: 15),
                                  child: const Text(
                                    'Komentar : ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: AlignmentDirectional.topStart,
                                  child: Text(
                                    controller.data['komentar'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
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
