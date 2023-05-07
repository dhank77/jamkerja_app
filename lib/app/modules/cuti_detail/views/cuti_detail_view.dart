import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jamkerja/app/component/app_bar.dart';
import 'package:jamkerja/app/component/child/hero_image.dart';
import 'package:jamkerja/app/component/child/status.dart';
import 'package:jamkerja/app/component/pdf_view.dart';
import 'package:jamkerja/app/constant/api_const.dart';
import 'package:path/path.dart' as path;
import '../controllers/cuti_detail_controller.dart';

class CutiDetailView extends GetView<CutiDetailController> {
  const CutiDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      body: Container(
        color: Colors.blue[50],
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            controller.data['status'].toString().toUpperCase() == "DITERIMA"
                ? Column(
                    children: [
                      Container(
                        alignment: AlignmentDirectional.topStart,
                        child: const Text(
                          'File Persetujuan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (path.extension(controller.data['file']) ==
                              '.pdf') {
                            Get.to(PdfPage(file: controller.data['file']));
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HeroPhotoViewRouteWrapper(
                                  imageProvider: NetworkImage(
                                    controller.data['file'] == ''
                                        ? '${BASEURL}no-file.png'
                                        : controller.data['file'],
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 200,
                                    child: CachedNetworkImage(
                                      imageUrl: path.extension(
                                                  controller.data['file']) ==
                                              '.pdf'
                                          ? '${BASEURL}pdf.jpg'
                                          : (controller.data['file'] == ''
                                              ? '${BASEURL}no-file.png'
                                              : controller.data['file']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                controller.data['cuti'],
                style: const TextStyle(
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
                            'Tanggal Mulai',
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            controller.data['tanggal_mulai'],
                          ),
                        ),
                      ],
                      rows: <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            const DataCell(
                              Text(
                                'Tanggal Selesai',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                controller.data['tanggal_selesai'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
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
                                child:
                                    Status(status: controller.data['status']),
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
                          const EdgeInsets.only(left: 25, top: 5, right: 25),
                      child: Column(
                        children: [
                          Container(
                            alignment: AlignmentDirectional.topStart,
                            margin: const EdgeInsets.only(bottom: 10),
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
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
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
