import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jamkerja/app/data/shift_provider.dart';
import 'package:jamkerja/app/function/alert.dart';
import 'package:jamkerja/app/routes/app_pages.dart';

class ShiftAddController extends GetxController {
  final kodeCuti = ''.obs;
  final animate = false.obs;
  final TextEditingController keterangan = TextEditingController();
  final dataUser = GetStorage().read('dataUser');
  final List<dynamic> list = [].obs;

  void getMasterCuti() {
    list.add({'value': '', 'kode_shift': '', 'label': 'Pilih'});
    try {
      ShiftProvider().getMasterShift(dataUser['access_token']).then((value) {
        list.addAll(value.body);
      });
    } catch (e) {
      print(e);
    }
  }

  void sendData() {
    try {
      animate.value = true;
      ShiftProvider()
          .postShift(
        dataUser['access_token'],
        dataUser['nip'],
        kodeCuti.value.toString(),
        keterangan.text,
      )
          .then((value) {
        final data = value.body;
        animate.value = false;
        if (data['status'] == true) {
          dialogSuccess('Berhasil Mengajukan!',
              () => Get.offAllNamed(Routes.NAVIGATION_BOTTOM));
        } else {
          dialogError(data['messages']);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    getMasterCuti();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
