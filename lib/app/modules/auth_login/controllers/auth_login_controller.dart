import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jamkerja/app/data/providers/user_provider.dart';
import 'package:jamkerja/app/function/alert.dart';
import 'package:jamkerja/app/routes/app_pages.dart';

class AuthLoginController extends GetxController {
  final hide = true.obs;
  final animate = false.obs;
  late TextEditingController email;
  late TextEditingController password;

  var playerId = GetStorage().read('playerId');
  var imei = GetStorage().read('imei');

  void login() async {
    // await getImei();

    if (email.text != '' &&
        password.text != '' &&
        imei != '' &&
        playerId != "") {
      try {
        animate.value = true;
        await UserProvider()
            .login(email.text, password.text, imei, playerId)
            .then((value) {
          if (value.body == null || value.body == '') {
            animate.value = false;
            dialogError('Pastikan Koneksi Internet Anda Baik!');
          } else {
            if (value.body['access_token'] != null) {
              final data = value.body;
              final box = GetStorage();
              box.write('dataUser', {
                'kode_perusahaan': data['user']['kode_perusahaan'].toString(),
                'name': data['user']['name'].toString(),
                'no_hp': data['user']['no_hp'].toString(),
                'email': data['user']['email'].toString(),
                'nip': data['user']['nip'].toString(),
                'jabatan': data['user']['nama_jabatan'].toString(),
                'skpd': data['user']['skpd'].toString(),
                'images': data['user']['images'].toString(),
                'access_token': data['access_token'].toString(),
              });
              Get.offAllNamed(Routes.NAVIGATION_BOTTOM);
            } else {
              animate.value = false;
              dialogError(value.body['message']);
            }
          }
        });
      } catch (e) {
        print(e);
        animate.value = false;
        dialogError('Error, ${e.toString()}!');
      }
    } else {
      dialogError('NIP dan Password wajib diisi!');
    }
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    // email = TextEditingController(text: 'hocamu@mailinator.com');
    // password = TextEditingController(text: 'hocamu@mailinator.com');
    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
