import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jamkerja/app/component/app_bar.dart';
import 'package:jamkerja/app/component/child/navigation_bar_bottom.dart';
import 'package:jamkerja/app/component/list_profile.dart';
import 'package:jamkerja/app/constant/api_const.dart';

import '../controllers/profil_controller.dart';

class ProfilView extends GetView<ProfilController> {
  const ProfilView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      body: Column(
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
                        GestureDetector(
                          onTap: () => controller.getImage(),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: controller.dataUser['images'] != ""
                                      ? CachedNetworkImage(
                                          imageUrl: controller.dataUser['images'],
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(
                                            color: Colors.blue,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          width: 100.0,
                                          height: 100.0,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset("assets/images/noimage.png"),
                                ),
                                  const Positioned(
                                bottom: 8,
                                right: 3,
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.black87,
                                ),
                              ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            controller.dataUser['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              controller.dataUser['jabatan'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                decoration: TextDecoration.none,
                              ),
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
                            Colors.blue.withOpacity(0.5),
                            Colors.white70
                          ],
                        ),
                      ),
                      child: Obx(
                        () => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListProfile(
                                  title: 'No. Telepon',
                                  value:
                                      controller.dataUser['no_hp'].toString(),
                                  icon: Icons.phone_in_talk_outlined,
                                ),
                                ListProfile(
                                  title: 'Email',
                                  value:
                                      controller.dataUser['email'].toString(),
                                  icon: Icons.mail,
                                ),
                                ListProfile(
                                  title: 'Jabatan',
                                  value: controller.dataUser['jabatan'],
                                  icon: Icons.work,
                                ),
                                ListProfile(
                                  title: 'Divisi Kerja',
                                  value: controller.dataUser['skpd'],
                                  icon: Icons.location_history,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 140,
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(5),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                              ),
                                            ),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.blue),
                                          ),
                                          onPressed: controller.animate.isFalse
                                              ? controller.logout
                                              : () {},
                                          child: controller.animate.isFalse
                                              ? Text(
                                                  'Logout',
                                                  textAlign: TextAlign.center,
                                                )
                                              : Container(
                                                  width: 20,
                                                  height: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
