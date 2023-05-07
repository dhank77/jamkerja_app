import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jamkerja/app/data/presensi_provider.dart';
import 'package:jamkerja/app/function/alert.dart';
import 'package:jamkerja/app/routes/app_pages.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trust_location/trust_location.dart';

class MenuPresensiController extends GetxController {
  var dataUser = GetStorage().read('dataUser');

  final longitude = 0.0.obs;
  final latitude = 0.0.obs;
  final longlat = ''.obs;
  final alamat = ''.obs;

  final dateTime = DateTime.now().obs;

  final shiftStatus = false.obs;
  final shiftData = {}.obs;
  final lokasiData = {}.obs;
  final hariData = {}.obs;

  final animate = false.obs;
  final tombol_text = '-'.obs;

  void updatePosition() async {
    Map<String, dynamic> dataPosition = await getPosition();
    if (!dataPosition['error']) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          dataPosition['position'].latitude,
          dataPosition['position'].longitude);
      alamat.value = placemarks[0].street.toString() +
          ", " +
          placemarks[0].subLocality.toString() +
          ", " +
          placemarks[0].country.toString();
      longlat.value = dataPosition['position'].latitude.toString() +
          ", " +
          dataPosition['position'].longitude.toString();
      latitude.value = dataPosition['position'].latitude;
      longitude.value = dataPosition['position'].longitude;
    } else {
      dialogError(dataPosition['message']);
    }
  }

  Future<Map<String, dynamic>> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return {
        "message": "Handphone anda tidak mendukung fitur GPS!",
        "error": true,
      };
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return {
          "message": "Perizinan Lokasi ditolak",
          "error": true,
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return {
        "message": "Harap Mengaktifkan Perizinan Lokasi Anda",
        "error": true,
      };
    }

    return {
      "position": await Geolocator.getCurrentPosition(),
      "message": "Berhasil",
      "error": false,
    };
  }

  void callIncrement() {
    dateTime.value = DateTime.now();
  }

  void getShift() {
    try {
      PresensiProvider()
          .getShift(dataUser['access_token'], dataUser['nip'])
          .then(
        (value) {
          final data = value.body;
          if (data != null) {
            shiftData.value = data;
            if ((dateTime.value.millisecondsSinceEpoch / 1000 >=
                        data['jam_buka_datang'] &&
                    dateTime.value.millisecondsSinceEpoch / 1000 <=
                        data['jam_tutup_datang']) &&
                hariData['datang'] == false) {
              shiftStatus.value = true;
              tombol_text.value = 'Presensi Datang';
            } else if ((dateTime.value.millisecondsSinceEpoch / 1000 >=
                        data['jam_buka_pulang'] &&
                    dateTime.value.millisecondsSinceEpoch / 1000 <=
                        data['jam_tutup_pulang']) &&
                hariData['pulang'] == false) {
              shiftStatus.value = true;
              tombol_text.value = 'Presensi Pulang';
            } else if ((dateTime.value.millisecondsSinceEpoch / 1000 >=
                    data['jam_buka_istirahat'] &&
                dateTime.value.millisecondsSinceEpoch / 1000 <=
                    data['jam_tutup_istirahat'] &&
                data['jam_buka_istirahat'] != 0 &&
                data['jam_tutup_istirahat'] != 0 &&
                hariData['istirahat'] == false)) {
              shiftStatus.value = true;
              tombol_text.value = 'Presensi Istirahat';
            } else {
              shiftStatus.value = false;
              tombol_text.value = 'Tutup';
            }
          } else {
            dialogError('Data Shift Anda Tidak Ditemukan!');
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }

  void getLokasi() {
    try {
      PresensiProvider()
          .getLokasi(dataUser['access_token'], dataUser['nip'])
          .then((value) {
        final data = value.body;
        if (data != null) {
          lokasiData.value = data;
        } else {
          dialogError('Data Lokasi Anda Tidak Ditemukan');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<bool> onRadiusDistance() async {
    if (latitude.value == 0.0 || longitude.value == 0.0) {
      return false;
    } else {
      double distanceInMeters = Geolocator.distanceBetween(
        double.parse(lokasiData['latitude']),
        double.parse(lokasiData['longitude']),
        latitude.value,
        longitude.value,
      );
      if (distanceInMeters < double.parse(lokasiData['jarak'].toString())) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> isFakeGPS() async {
    if (Platform.isAndroid) {
      await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      bool isMockLocation = await TrustLocation.isMockLocation;
      return isMockLocation;
    } else {
      return false;
    }
  }

  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  var compressImagePath = ''.obs;
  var compressImageSize = ''.obs;

  Future getImage(ImageSource imageSource) async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(
        source: imageSource, preferredCameraDevice: CameraDevice.front);
    if (image != null) {
      selectedImagePath.value = image.path;
      selectedImageSize.value =
          ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              " Mb";
    } else {
      Get.snackbar("Error", "No Selected Image",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> moveCamera() async {
    XFile picture = await Get.toNamed(Routes.CAMERA_FRONT);
    selectedImagePath.value = picture.path;
    selectedImageSize.value =
        "${((File(selectedImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";

    // Compress
    final dir = await Directory.systemTemp;
    final targetPath = "${dir.absolute.path}/temp.jpg";
    var compressedFile = await FlutterImageCompress.compressAndGetFile(
      selectedImagePath.value,
      targetPath,
      quality: 90,
    );
    compressImagePath.value = compressedFile!.path;
    compressImageSize.value =
        "${((File(compressImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";
  }

  void presensi() async {
    if (shiftStatus.isFalse) {
      dialogError('Presensi Belum dibuka!');
      return;
    }

    // await getImage(ImageSource.camera);
    await moveCamera();

    if (compressImagePath.value != "") {
      final bytes = File(compressImagePath.value).readAsBytesSync();
      String img64 = "data:image/png;base64," + base64Encode(bytes);

      animate.value = true;
      bool onOfficeRadius = await onRadiusDistance();
      bool isFakeLocation = await isFakeGPS();

      if (double.parse(lokasiData['latitude']) == 0.0 ||
          double.parse(lokasiData['longitude']) == 0.0) {
        dialogError('Silahkan Sesuaikan Lokasi Anda Terlebih dahulu!');
      } else if (!onOfficeRadius) {
        dialogError('Anda tidak berada di sekitar area kantor!');
      } else if (isFakeLocation) {
        dialogError('Anda Terdeteksi Menggunakan Fake Location!');
      } else {
        await PresensiProvider()
            .postPresensi(
          dataUser['nip'],
          dataUser['access_token'],
          longlat.value.toString(),
          shiftData['kode_shift'].toString(),
          shiftData['kode_tingkat'].toString(),
          img64,
        )
            .then((value) {
          var data = value.body;
          if (data['status'] == 'Success') {
            dialogSuccess(data['messages'],
                () => Get.offAllNamed(Routes.NAVIGATION_BOTTOM));
          } else {
            dialogError(data['messages']);
          }
        });
      }
    } else {
      dialogError('Anda belum mengambil gambar!');
    }
  }

  void getHariIni() {
    try {
      PresensiProvider()
          .getHariIni(dataUser['access_token'], dataUser['nip'])
          .then((value) {
        hariData.value = value.body;
        getShift();
        getLokasi();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    getHariIni();
    updatePosition();
    Timer.periodic(Duration(seconds: 1), (_) => callIncrement());
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
