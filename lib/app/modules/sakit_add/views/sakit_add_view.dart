import 'package:absensisbc/app/component/app_bar.dart';
import 'package:absensisbc/app/form/button.dart';
import 'package:absensisbc/app/form/form_date.dart';
import 'package:absensisbc/app/form/form_input.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:get/get.dart';

import '../controllers/sakit_add_controller.dart';

class SakitAddView extends GetView<SakitAddController> {
  const SakitAddView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.amber[50],
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              FormDate(
                change: (value) =>
                    controller.tanggalMulai.value = value.toString(),
                init: DateTime.now(),
                label: "Tanggal Mulai",
              ),
              FormDate(
                change: (value) =>
                    controller.tanggalSelesai.value = value.toString(),
                init: DateTime.now(),
                label: "Tanggal Selesai",
              ),
              FormInput(
                control: controller.keterangan,
                title: "Keterangan",
                icon: Icons.message,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Obx(
                  () => GestureDetector(
                    onTap: () => controller.getImage(),
                    child: controller.selectedImagePath.value == ""
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Pilih Gambar",
                                style: TextStyle(
                                  color: Colors.amber,
                                ),
                              ),
                              Container(
                                width: 1000,
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.image_search,
                                  size: 50,
                                ),
                              ),
                            ],
                          )
                        : SizedBox(
                            width: 1000,
                            height: 100,
                            child: Image.file(
                              File(controller.selectedImagePath.value),
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => Button(
                  fnc: () => controller.sendData(),
                  animate: controller.animate.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
