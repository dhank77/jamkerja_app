import 'dart:io';

import 'package:jamkerja/app/component/app_bar.dart';
import 'package:jamkerja/app/form/button.dart';
import 'package:jamkerja/app/form/form_date.dart';
import 'package:jamkerja/app/form/form_input.dart';
import 'package:jamkerja/app/form/form_select.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/izin_add_controller.dart';

class IzinAddView extends GetView<IzinAddController> {
  const IzinAddView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      body: Container(
        color: Colors.blue[50],
        height: Get.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => controller.list.isNotEmpty
                    ? FormSelect(
                        label: "Pilih Pengajuan",
                        listData: controller.list.map((item) {
                          return DropdownMenuItem(
                            value: item['kode_izin'],
                            child: Text(item['label']),
                          );
                        }).toList(),
                        icon: Icons.outbox_rounded,
                        initialValue: controller.kodeIzin.value,
                        onChanged: (value) {
                          controller.kodeIzin.value = value.toString();
                        },
                      )
                    // ? Text(controller.list.toString())
                    : const SizedBox(),
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
                                  color: Colors.blue,
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
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
