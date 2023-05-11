import 'dart:convert';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jamkerja/app/data/providers/user_provider.dart';
import 'package:jamkerja/app/function/alert.dart';
import 'package:jamkerja/app/routes/app_pages.dart';

class ProfilController extends GetxController {
  var dataUser = GetStorage().read('dataUser');
  final animate = false.obs;
  final animateData = false.obs;

  void logout() {
    animate.value = true;
    GetStorage().remove('dataPegawai');
    Get.offAllNamed(Routes.AUTH_LOGIN);
  }

  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  // Compress code
  var compressImagePath = ''.obs;
  var compressImageSize = ''.obs;

  void getImage() async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          "${((File(selectedImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";

      // Compress
      final dir = await Directory.systemTemp;
      final targetPath = "${dir.absolute.path}/temp.jpg";
      var compressedFile = await FlutterImageCompress.compressAndGetFile(
          selectedImagePath.value, targetPath,
          quality: 60);
      compressImagePath.value = compressedFile!.path;
      compressImageSize.value =
          "${((File(compressImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";

      uploadImage(compressedFile);
    } else {
      dialogError('Pilih File Dahulu!');
    }
  }

  void uploadImage(File file) {
    List<int> imageBytes = file.readAsBytesSync();
    String baseimage = "data:image/png;base64,${base64Encode(imageBytes)}";
    try {
      UserProvider()
          .updateFotoProfile(
              dataUser['nip'], dataUser['access_token'], baseimage)
          .then((value) {
        final data = value.body;
        if (data['status'].toString() == "Success") {
          final box = GetStorage();
          box.write('dataUser', {
            'kode_perusahaan': dataUser['kode_perusahaan'].toString(),
            'name': dataUser['name'].toString(),
            'no_hp': dataUser['no_hp'].toString(),
            'email': dataUser['email'].toString(),
            'nip': dataUser['nip'].toString(),
            'jabatan': dataUser['jabatan'].toString(),
            'skpd': dataUser['skpd'].toString(),
            'images': data['user']['images'].toString(),
            'access_token': dataUser['access_token'].toString(),
          });
          
          dialogSuccess(data['messages'],
              () => Get.offAllNamed(Routes.NAVIGATION_BOTTOM));
        } else {
          dialogError('Terjadi Kesalahan!');
        }
      }, onError: (err) {
        dialogError('Upload Gagal!');
      });
    } catch (e) {
      dialogError('Upload Gagal!!!');
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
