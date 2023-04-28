import 'dart:io';

import 'package:absensisbc/app/component/app_bar.dart';
import 'package:absensisbc/app/form/button.dart';
import 'package:absensisbc/app/form/form_input.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/visit_add_controller.dart';

class VisitAddView extends GetView<VisitAddController> {
  const VisitAddView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: AlignmentDirectional.centerStart,
                child: const Text(
                  'Tambah Kunjungan',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            FormInput(
              control: controller.judul,
              title: "Judul",
              icon: Icons.title,
            ),
            FormInput(
              control: controller.keterangan,
              title: "Keterangan",
              icon: Icons.message,
            ),
            const SizedBox(height: 10),
            Obx(
              () => Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.amber[600],
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Text(
                      'Kordinat : ${controller.lat.value}, ${controller.long.value}\nLokasi : ${controller.lokasi.value}',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 40,
                    child: GestureDetector(
                      onTap: () => controller.getCurrentLocation(),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: const Icon(
                          Icons.restore,
                          size: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => controller.moveCamera(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: SizedBox(
                  width: 500.0,
                  height: 130.0,
                  child: Obx(
                    () => controller.compressImagePath.value == ''
                        ? Container(
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
                          )
                        : Image.file(
                            File(controller.compressImagePath.value),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => Button(
                fnc: () => controller.saveData(),
                animate: controller.animate.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
