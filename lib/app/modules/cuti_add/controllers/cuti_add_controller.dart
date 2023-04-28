import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:absensisbc/app/data/cuti_provider.dart';
import 'package:absensisbc/app/function/alert.dart';
import 'package:absensisbc/app/routes/app_pages.dart';
import 'package:image_picker/image_picker.dart';

class CutiAddController extends GetxController {
  final kodeCuti = ''.obs;
  final tanggalMulai = ''.obs;
  final tanggalSelesai = ''.obs;
  final animate = false.obs;
  final TextEditingController keterangan = TextEditingController();
  final dataUser = GetStorage().read('dataUser');
  final List<dynamic> list = [].obs;

  void getMasterCuti() {
    list.add({'value': '', 'kode_cuti': '', 'label': 'Pilih'});
    try {
      CutiProvider().getMasterCuti(dataUser['access_token']).then((value) {
        list.addAll(value.body);
      });
    } catch (e) {
      print(e);
    }
  }

  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  File? imageFile;

  Future getImage() async {
    selectedImagePath.value = '';
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 10,
    );
    if (image != null) {
      selectedImagePath.value = image.path;
      imageFile = File(image.path);
      selectedImageSize.value =
          "${((File(selectedImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";
    } else {
      Get.snackbar("Error", "No Selected Image",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void sendData() {
    try {
      if (imageFile == null) {
        dialogError("Gambar wajib dipilih!");
      } else {
        animate.value = true;
        List<int> imageBytes = imageFile!.readAsBytesSync();
        String baseimage = "data:image/png;base64,${base64Encode(imageBytes)}";
        CutiProvider()
            .postCuti(
          dataUser['access_token'],
          dataUser['nip'],
          tanggalMulai.value.toString(),
          tanggalSelesai.value.toString(),
          kodeCuti.value.toString(),
          keterangan.text,
          baseimage,
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
      }
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
