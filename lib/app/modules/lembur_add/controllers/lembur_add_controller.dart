import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jamkerja/app/data/lembur_provider.dart';
import 'package:jamkerja/app/function/alert.dart';
import 'package:jamkerja/app/routes/app_pages.dart';
import 'package:image_picker/image_picker.dart';

class LemburAddController extends GetxController {
  final tanggal = ''.obs;
  final TextEditingController keterangan = TextEditingController();
  final TextEditingController mulai = TextEditingController();
  final TextEditingController selesai = TextEditingController();
  final animate = false.obs;
  final dataUser = GetStorage().read('dataUser');

  Future<void> showMulai() async {
    final split = mulai.text.split(':');
    final TimeOfDay? result = await showTimePicker(
      context: Get.context!,
      initialTime: mulai.text != ''
          ? TimeOfDay(hour: int.parse(split[0]), minute: int.parse(split[1]))
          : TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.amber,
              onSurface: Colors.black,
            ),
            buttonTheme: ButtonThemeData(
              colorScheme: ColorScheme.light(
                primary: Colors.amber,
              ),
            ),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: true,
            ),
            child: child!,
          ),
        );
      },
    );
    if (result != null) {
      mulai.text = result.hour.toString() + ':' + result.minute.toString();
    }
  }

  Future<void> showSelesai() async {
    final split = selesai.text.split(':');
    final TimeOfDay? result = await showTimePicker(
      context: Get.context!,
      initialTime: selesai.text != ''
          ? TimeOfDay(hour: int.parse(split[0]), minute: int.parse(split[1]))
          : TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.amber,
              onSurface: Colors.black,
            ),
            buttonTheme: ButtonThemeData(
              colorScheme: ColorScheme.light(
                primary: Colors.amber,
              ),
            ),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: true,
            ),
            child: child!,
          ),
        );
      },
    );
    if (result != null) {
      selesai.text = result.hour.toString() + ':' + result.minute.toString();
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
      animate.value = true;
      if (imageFile == null) {
        dialogError("Gambar wajib dipilih!");
      } else {
        List<int> imageBytes = imageFile!.readAsBytesSync();
        String baseimage = "data:image/png;base64,${base64Encode(imageBytes)}";
        LemburProvider()
            .postLembur(
          dataUser['access_token'],
          dataUser['nip'],
          tanggal.value.toString(),
          mulai.text,
          selesai.text,
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
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
