import 'dart:convert';
import 'dart:io';

import 'package:jamkerja/app/data/ijin_provider.dart';
import 'package:jamkerja/app/function/alert.dart';
import 'package:jamkerja/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class IjinAddController extends GetxController {
  final kodeIjin = ''.obs;
  final TextEditingController mulai = TextEditingController();
  final TextEditingController selesai = TextEditingController();
  final animate = false.obs;
  final TextEditingController keterangan = TextEditingController();
  final dataUser = GetStorage().read('dataUser');
  final List<dynamic> list = [].obs;

  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  File? imageFile;

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
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onSurface: Colors.black,
            ),
            buttonTheme: const ButtonThemeData(
              colorScheme: ColorScheme.light(
                primary: Colors.blue,
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
      mulai.text = '${result.hour}:${result.minute}';
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
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onSurface: Colors.black,
            ),
            buttonTheme: const ButtonThemeData(
              colorScheme: ColorScheme.light(
                primary: Colors.blue,
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
      selesai.text = '${result.hour}:${result.minute}';
    }
  }

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

  void getMasterCuti() {
    list.add({'value': '', 'kode_ijin': '', 'label': 'Pilih'});
    try {
      IjinProvider().getMaster(dataUser['access_token']).then((value) {
        list.addAll(value.body);
      });
    } catch (e) {
      print(e);
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
        IjinProvider()
            .postijin(
          dataUser['access_token'],
          dataUser['nip'],
          mulai.text,
          selesai.text,
          kodeIjin.value.toString(),
          keterangan.text,
          baseimage,
        )
            .then((value) {
          final data = value;
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
