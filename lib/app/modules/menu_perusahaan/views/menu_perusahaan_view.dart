import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:absensisbc/app/component/app_bar.dart';
import 'package:absensisbc/app/component/list_profile.dart';

import '../controllers/menu_perusahaan_controller.dart';

class MenuPerusahaanView extends GetView<MenuPerusahaanController> {
  const MenuPerusahaanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      body: Obx(
        () => controller.perusahaan.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            height: 180.0,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: controller.perusahaan[0]['logo'] !=
                                            ""
                                        ? CachedNetworkImage(
                                            imageUrl: controller.perusahaan[0]
                                                ['logo'],
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(
                                              color: Colors.amber,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                            height: 100.0,
                                          )
                                        : Image.asset(
                                            "assets/images/noimage.png"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    controller.perusahaan[0]['nama'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30)),
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Colors.amber.withOpacity(0.5),
                                    Colors.white70
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ListProfile(
                                        title: 'Direktur',
                                        value: controller.perusahaan[0]
                                            ['direktur'],
                                        icon: Icons.person_sharp,
                                      ),
                                      Obx(
                                        () => controller.perusahaan[0]['nomor']
                                                    .toString() !=
                                                "null"
                                            ? ListProfile(
                                                title: 'Nomor Pegawai Direktur',
                                                value: controller.perusahaan[0]
                                                    ['nomor'],
                                                icon: Icons
                                                    .perm_contact_cal_sharp,
                                              )
                                            : Container(),
                                      ),
                                      ListProfile(
                                        title: 'Alamat',
                                        value: controller.perusahaan[0]
                                            ['alamat'],
                                        icon: Icons.add_location_sharp,
                                      ),
                                      ListProfile(
                                        title: 'Kontak',
                                        value: controller.perusahaan[0]
                                            ['kontak'],
                                        icon: Icons.contact_mail,
                                      ),
                                    ],
                                  ),
                                ),
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
                  color: Colors.red,
                ),
              ),
      ),
    );
  }
}
