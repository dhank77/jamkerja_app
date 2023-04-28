import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:absensisbc/app/data/reimbursement_provider.dart';
import 'package:absensisbc/app/function/alert.dart';
import 'package:absensisbc/app/routes/app_pages.dart';

class ReimbursementAddController extends GetxController {
  final kodeReimbursement = ''.obs;
  final animate = false.obs;
  final TextEditingController keterangan = TextEditingController();
  final TextEditingController nilai =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  final dataUser = GetStorage().read('dataUser');
  final List<dynamic> list = [].obs;

  void getMasterCuti() {
    list.add({'value': '', 'kode_reimbursement': '', 'label': 'Pilih'});
    try {
      ReimbursementProvider()
          .getMasterReimbursement(dataUser['access_token'])
          .then((value) {
        list.addAll(value.body);
      });
    } catch (e) {
      print(e);
    }
  }

  void sendData() {
    try {
      if (kodeReimbursement.value.toString() == "" || nilai.text == "") {
        dialogError('Harap Mengisi data dengan benar!');
        return;
      }
      animate.value = true;
      ReimbursementProvider()
          .postReimbursement(
        dataUser['access_token'],
        dataUser['nip'],
        nilai.text,
        kodeReimbursement.value.toString(),
        keterangan.text,
      )
          .then((value) {
        final data = value.body;
        animate.value = false;
        if (data['status'] == true) {
          dialogSuccess('Berhasil Mengajukan!',
              () => Get.offAllNamed(Routes.NAVIGATION_BOTTOM));
        } else {
          dialogError('Gagal Mengajukan!');
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
