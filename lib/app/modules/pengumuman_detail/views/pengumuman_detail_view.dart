import 'package:jamkerja/app/component/app_bar.dart';
import 'package:jamkerja/app/component/child/hero_image.dart';
import 'package:jamkerja/app/component/pdf_view.dart';
import 'package:jamkerja/app/constant/api_const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;

import '../controllers/pengumuman_detail_controller.dart';

class PengumumanDetailView extends GetView<PengumumanDetailController> {
  const PengumumanDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                if (path.extension(controller.data['file'].toString()) ==
                    '.pdf') {
                  Get.to(PdfPage(file: controller.data['file'].toString()));
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HeroPhotoViewRouteWrapper(
                        imageProvider: NetworkImage(
                          controller.data['file'].toString() == ''
                              ? BASEURL + 'no-file.png'
                              : controller.data['file'].toString(),
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
                                        controller.data['file'].toString()) ==
                                    '.pdf'
                                ? BASEURL + 'pdf.jpg'
                                : (controller.data['file'].toString() == ''
                                    ? BASEURL + 'no-file.png'
                                    : controller.data['file'].toString()),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                controller.data['judul'].toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                controller.data['deskripsi'].toString(),
                style: const TextStyle(
                  fontSize: 12,
                ),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }
}
