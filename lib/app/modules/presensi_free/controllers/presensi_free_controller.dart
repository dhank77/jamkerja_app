import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:absensisbc/app/data/presensi_provider.dart';
import 'package:absensisbc/app/function/alert.dart';
import 'package:absensisbc/app/routes/app_pages.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart' as loc;
import 'package:trust_location/trust_location.dart';

class PresensiFreeController extends GetxController {
  var dataUser = GetStorage().read('dataUser');

  final lat = double.parse("-7.688264").obs;
  final long = 112.273356.obs;
  final dateTime = DateTime.now().obs;
  Completer<GoogleMapController> ctrmaps = Completer();

  final animate1 = false.obs;
  final animate2 = false.obs;
  final animate3 = false.obs;
  final animate4 = false.obs;

  final lokasiData = {}.obs;

  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  var compressImagePath = ''.obs;
  var compressImageSize = ''.obs;

  Future getImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(
      source: imageSource,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 10,
    );
    if (image != null) {
      selectedImagePath.value = image.path;
      selectedImageSize.value =
          "${((File(selectedImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";

      final dir = Directory.systemTemp;
      final targetPath = "${dir.absolute.path}/temp.jpg";
      var compressedFile = await FlutterImageCompress.compressAndGetFile(
          selectedImagePath.value, targetPath,
          quality: 50);
      compressImagePath.value = compressedFile!.path;
      compressImageSize.value =
          "${((File(compressImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";
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

  void checkIn() async {
    animate1.value = true;
    try {
      // await getImage(ImageSource.camera);
      await moveCamera();

      if (compressImagePath.value != "") {
        final bytes = File(compressImagePath.value).readAsBytesSync();
        String img64 = "data:image/png;base64,${base64Encode(bytes)}";

        bool onOfficeRadius = await onRadiusDistance();
        bool isFakeLocation = isMock.value; //await isFakeGPS();

        if (double.parse(lokasiData['latitude']) == -7.688264 ||
            double.parse(lokasiData['longitude']) == 112.273356) {
          animate1.value = false;
          dialogError('Silahkan Sesuaikan Lokasi Anda Terlebih dahulu!');
        } else if (!onOfficeRadius) {
          animate1.value = false;
          dialogError('Anda tidak berada di sekitar area kantor!');
        } else if (isFakeLocation) {
          animate1.value = false;
          dialogError('Anda Terdeteksi Menggunakan Fake Location!');
        } else {
          await PresensiProvider()
              .postPresensiFree(
            dataUser['nip'].toString(),
            dataUser['access_token'].toString(),
            "${lat.value.toString()}, ${long.value.toString()}",
            img64.toString(),
            "datang",
          )
              .then((value) {
            animate1.value = false;
            compressImagePath.value = "";
            if (value['status'] == 'Error') {
              dialogError(value['messages']);
            } else {
              dialogSuccess(value['messages'], () => Get.back());
            }
          });
        }
      } else {
        animate1.value = false;
        dialogError("Pilih Gambar terlebih dahulu!");
      }
    } catch (e) {
      animate1.value = false;
      // dialogError("Sedang dalam perbaikan! ${e.toString()}");
      print(e);
    }
  }

  void checkOut() async {
    animate2.value = true;
    try {
      // await getImage(ImageSource.camera);
      await moveCamera();

      if (compressImagePath.value != "") {
        final bytes = File(compressImagePath.value).readAsBytesSync();
        String img64 = "data:image/png;base64,${base64Encode(bytes)}";

        bool onOfficeRadius = await onRadiusDistance();
        bool isFakeLocation = isMock.value; //await isFakeGPS();

        if (double.parse(lokasiData['latitude']) == -7.688264 ||
            double.parse(lokasiData['longitude']) == 112.273356) {
          animate2.value = false;
          dialogError('Silahkan Sesuaikan Lokasi Anda Terlebih dahulu!');
        } else if (!onOfficeRadius) {
          animate2.value = false;
          dialogError('Anda tidak berada di sekitar area kantor!');
        } else if (isFakeLocation) {
          animate2.value = false;
          dialogError('Anda Terdeteksi Menggunakan Fake Location!');
        } else {
          await PresensiProvider()
              .postPresensiFree(
            dataUser['nip'].toString(),
            dataUser['access_token'].toString(),
            "${lat.value.toString()}, ${long.value.toString()}",
            img64.toString(),
            "pulang",
          )
              .then((value) {
            animate2.value = false;
            compressImagePath.value = "";
            if (value['status'] == 'Error') {
              dialogError(value['messages']);
            } else {
              dialogSuccess(value['messages'], () => Get.back());
            }
          });
        }
      } else {
        animate2.value = false;
        dialogError("Pilih Gambar terlebih dahulu!");
      }
    } catch (e) {
      animate2.value = false;
      // dialogError("Sedang dalam perbaikan! ${e.toString()}");
      print(e);
    }
  }

  void istirahatMulai() async {
    animate3.value = true;
    try {
      bool onOfficeRadius = await onRadiusDistance();
      bool isFakeLocation = isMock.value; //await isFakeGPS();

      if (double.parse(lokasiData['latitude']) == -7.688264 ||
          double.parse(lokasiData['longitude']) == 112.273356) {
        animate3.value = false;
        dialogError('Silahkan Sesuaikan Lokasi Anda Terlebih dahulu!');
      } else if (!onOfficeRadius) {
        animate3.value = false;
        dialogError('Anda tidak berada di sekitar area kantor!');
      } else if (isFakeLocation) {
        animate3.value = false;
        dialogError('Anda Terdeteksi Menggunakan Fake Location!');
      } else {
        await PresensiProvider()
            .postPresensiFree(
          dataUser['nip'].toString(),
          dataUser['access_token'].toString(),
          "${lat.value.toString()}, ${long.value.toString()}",
          "",
          "istirahat_mulai",
        )
            .then((value) {
          animate3.value = false;
          compressImagePath.value = "";
          if (value['status'] == 'Error') {
            dialogError(value['messages']);
          } else {
            dialogSuccess(value['messages'], () => Get.back());
          }
        });
      }
    } catch (e) {
      animate3.value = false;
      //dialogError("Sedang dalam perbaikan! ${e.toString()}");
      print(e);
    }
  }

  void istirahatSelesai() async {
    animate4.value = true;
    try {
      bool onOfficeRadius = await onRadiusDistance();
      bool isFakeLocation = isMock.value; //isMock.value; //await isFakeGPS();

      if (double.parse(lokasiData['latitude']) == -7.688264 ||
          double.parse(lokasiData['longitude']) == 112.273356) {
        animate4.value = false;
        dialogError('Silahkan Sesuaikan Lokasi Anda Terlebih dahulu!');
      } else if (!onOfficeRadius) {
        animate4.value = false;
        dialogError('Anda tidak berada di sekitar area kantor!');
      } else if (isFakeLocation) {
        animate4.value = false;
        dialogError('Anda Terdeteksi Menggunakan Fake Location!');
      } else {
        await PresensiProvider()
            .postPresensiFree(
          dataUser['nip'].toString(),
          dataUser['access_token'].toString(),
          "${lat.value.toString()}, ${long.value.toString()}",
          "",
          "istirahat_selesai",
        )
            .then((value) {
          animate4.value = false;
          compressImagePath.value = "";
          if (value['status'] == 'Error') {
            dialogError(value['messages']);
          } else {
            dialogSuccess(value['messages'], () => Get.back());
          }
        });
      }
    } catch (e) {
      animate4.value = false;
      //dialogError("Sedang dalam perbaikan! ${e.toString()}");
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

    goToCoord();
  }

  Future<void> goToCoord() async {
    final GoogleMapController controller = await ctrmaps.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat.value, long.value),
          zoom: 18,
        ),
      ),
    );
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
    if (lat.value == -7.688264 || long.value == 112.273356) {
      return false;
    } else {
      double distanceInMeters = Geolocator.distanceBetween(
        double.parse(lokasiData['latitude']),
        double.parse(lokasiData['longitude']),
        lat.value,
        long.value,
      );
      if (distanceInMeters < double.parse(lokasiData['jarak'].toString())) {
        return true;
      } else {
        return false;
      }
    }
  }

  final isMock = false.obs;
  void isFakeGPS() {
    try {
      TrustLocation.onChange.listen((values) {
        isMock.value = values.isMockLocation!;
      });
    } catch (e) {
      print(e);
    }

    // if (Platform.isAndroid) {
    //   bool isMockLocation = await TrustLocation.isMockLocation;
    //   return isMockLocation;
    // } else {
    //   return false;
    // }
  }

  void callIncrement() {
    dateTime.value = DateTime.now();
  }

  @override
  void onInit() {
    getLokasi();
    isFakeGPS();
    getCurrentLocation();
    Timer.periodic(const Duration(seconds: 1), (_) => callIncrement());
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
