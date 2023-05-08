import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jamkerja/app/data/visit_provider.dart';
import 'package:jamkerja/app/function/alert.dart';
import 'package:jamkerja/app/function/distance.dart';
import 'package:jamkerja/app/routes/app_pages.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as loc;

class MenuVisitController extends GetxController {
  var listData = List<dynamic>.empty(growable: true).obs;
  final picked = ''.obs;
  final pickedStart = DateFormat('dd-MM-yyyy')
      .format(DateTime.now().subtract(Duration(days: 7)))
      .toString()
      .obs;
  final pickedEnd =
      DateFormat('dd-MM-yyyy').format(DateTime.now()).toString().obs;
  String dateToday = DateTime.now().toString().substring(0, 10);
  var isDataProcessing = false.obs;
  var dataUser = GetStorage().read('dataUser');

  final kodeVisit = "".obs;
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  final longitude = 0.0.obs;
  final latitude = 0.0.obs;
  final longlat = ''.obs;

  final lokasiData = {}.obs;

  Future<Map<String, dynamic>> getPosition() async {
    loc.Location location = loc.Location();

    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
          return {
          "message": "Harap Mengaktifkan Perizinan Lokasi Anda",
          "error": true,
        };
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
          return {
          "message": "Harap Mengaktifkan Perizinan Lokasi Anda",
          "error": true,
        };
      }
    }

    return {
      "position": await location.getLocation(),
      "message": "Berhasil",
      "error": false,
    };
  }

  Future<void> updatePosition() async {
    Map<String, dynamic> dataPosition = await getPosition();
    if (!dataPosition['error']) {
      longlat.value = "${dataPosition['position'].latitude}, ${dataPosition['position'].longitude}";
      latitude.value = dataPosition['position'].latitude;
      longitude.value = dataPosition['position'].longitude;
    } else {
      dialogError(dataPosition['message']);
    }
  }

  Future<void> getLokasi() async {
    try {
      await VisitProvider()
          .getLokasi(dataUser['access_token'], kodeVisit.value)
          .then((value) {
        final data = value.body;
        if (data != null) {
          lokasiData.value = data;
        } else {
          dialogError('Lokasi Tidak ditemukan!');
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
      double distanceInMeters = calculateDistance(
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

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      isDataProcessing(true);
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      kodeVisit.value = barcodeScanRes;

      await getLokasi();
      await updatePosition();

      bool onOfficeRadius = await onRadiusDistance();

      await getImage(ImageSource.camera);

      if (!onOfficeRadius) {
        dialogError('Anda tidak berada di sekitar area kunjungan!');
      } else if (selectedImagePath.value != "") {
        final bytes = File(selectedImagePath.value).readAsBytesSync();
        String img64 = "data:image/png;base64," + base64Encode(bytes);
        try {
          await VisitProvider()
              .postData(
            dataUser['nip'],
            dataUser['access_token'],
            longlat.value.toString(),
            kodeVisit.value,
            img64,
          )
              .then((value) {
            var data = value.body;
            print(data);
            if (data['status'] == 'Success') {
              dialogSuccess(data['messages'],
                  () => Get.offAllNamed(Routes.NAVIGATION_BOTTOM));
            } else {
              dialogError(data['messages']);
            }
            isDataProcessing.value = false;
          });
        } catch (e) {
          isDataProcessing.value = false;
          dialogError("Pastikan koneksi internet anda stabil!");
        }
      } else {
        isDataProcessing.value = false;
        dialogError("Harap mengambil gambar dilokasi!");
      }
    } on PlatformException {
      isDataProcessing.value = false;
      barcodeScanRes = 'not';
    }
  }

  Future getImage(ImageSource imageSource) async {
    isDataProcessing(true);
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

  void getData() {
    try {
      listData.clear();
      VisitProvider()
          .getData(dataUser['access_token'], dataUser['nip'], pickedStart.value,
              pickedEnd.value)
          .then((resp) {
        listData.addAll(resp.body);
      });
    } catch (exception) {
      print(exception);
    }
  }

  @override
  void onInit() {
    getData();
    updatePosition();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
