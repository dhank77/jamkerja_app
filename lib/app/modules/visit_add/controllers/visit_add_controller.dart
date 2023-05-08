// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:jamkerja/app/data/visit_provider.dart';
import 'package:jamkerja/app/function/alert.dart';
import 'package:jamkerja/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart' as loc;

class VisitAddController extends GetxController {
  var result = Get.arguments;

  late TextEditingController judul;
  late TextEditingController keterangan;

  var dataUser = GetStorage().read('dataUser');
  final kategori = ''.obs;
  final lokasi = ''.obs;
  final lat = 0.0.obs;
  final long = 0.0.obs;
  final animate = false.obs;

  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  var compressImagePath = ''.obs;
  var compressImageSize = ''.obs;

  void moveCamera() async {
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

  void getImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          "${((File(selectedImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";

      // Compress
      final dir = await Directory.systemTemp;
      final targetPath = "${dir.absolute.path}/temp.jpg";
      var compressedFile = await FlutterImageCompress.compressAndGetFile(
          selectedImagePath.value, targetPath,
          quality: 90);
      compressImagePath.value = compressedFile!.path;
      compressImageSize.value =
          "${((File(compressImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";
    } else {
      dialogError('Pilih File Dahulu!');
    }
  }

  void saveData() {
    try {
      animate.value = true;
      List<int> imageBytes = File(compressImagePath.value).readAsBytesSync();
      String baseimage = "data:image/png;base64,${base64Encode(imageBytes)}";

      // String baseimage = '';
      VisitProvider()
          .saveData(
        dataUser['access_token'],
        dataUser['nip'],
        judul.text,
        keterangan.text,
        baseimage,
        '${lat.value}, ${long.value}',
        lokasi.value,
      )
          .then((data) {
        animate.value = false;
        if (data['status'].toString() == 'true') {
          dialogSuccess(data['messages'],
              () => Get.offAllNamed(Routes.NAVIGATION_BOTTOM));
        } else {
          dialogError(data['messages']);
        }
      });
    } catch (e) {
      animate.value = false;
      print(e);
    }
  }

  void getCurrentLocation() async {
    loc.Location location = loc.Location();

    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;
    loc.LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    lat.value = locationData.latitude!;
    long.value = locationData.longitude!;
    List<Placemark> placemarks = await placemarkFromCoordinates(lat.value, long.value);
    lokasi.value = "${placemarks[0].street}, ${placemarks[0].subLocality}, ${placemarks[0].country}";

  }

  @override
  void onInit() {
    getCurrentLocation();
    judul = TextEditingController();
    keterangan = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
