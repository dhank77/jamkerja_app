import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';

import 'package:jamkerja/app/data/lembur_provider.dart';
import 'package:jamkerja/app/data/presensi_provider.dart';
import 'package:jamkerja/app/function/alert.dart';
import 'package:jamkerja/app/function/distance.dart';
import 'package:jamkerja/app/routes/app_pages.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart' as loc;
import 'package:trust_location/trust_location.dart';

class PresensiLemburController extends GetxController {
  var dataUser = GetStorage().read('dataUser');

  final lat = double.parse("-7.688264").obs;
  final long = 112.273356.obs;

  final lembur = false.obs;

  final dateTime = DateTime.now().obs;
  Completer<GoogleMapController> ctrmaps = Completer();

  final animate1 = false.obs;
  final animate2 = false.obs;
  final id = ''.obs;

  final lokasiData = {}.obs;

  void checkInOut(String keyword) async {
    if (keyword == 'masuk') {
      animate1.value = true;
    } else {
      animate2.value = true;
    }
    try {
      bool onOfficeRadius = await onRadiusDistance();
      bool isFakeLocation = isMock.value;

      if (double.parse(lokasiData['latitude']) == -7.688264 ||
          double.parse(lokasiData['longitude']) == 112.273356) {
        if (keyword == 'masuk') {
          animate1.value = false;
        } else {
          animate2.value = false;
        }
        dialogError('Silahkan Sesuaikan Lokasi Anda Terlebih dahulu!');
      } else if (!onOfficeRadius) {
        if (keyword == 'masuk') {
          animate1.value = false;
        } else {
          animate2.value = false;
        }
        dialogError('Anda tidak berada di sekitar area kantor!');
      } else if (isFakeLocation) {
        if (keyword == 'masuk') {
          animate1.value = false;
        } else {
          animate2.value = false;
        }
        dialogError('Anda Terdeteksi Menggunakan Fake Location!');
      } else {
        print('here');
        await LemburProvider()
            .presensi(
          dataUser['nip'].toString(),
          dataUser['access_token'].toString(),
          id.value,
          "${lat.value.toString()}, ${long.value.toString()}",
          keyword,
        )
            .then((value) {
          if (keyword == 'masuk') {
          animate1.value = false;
        } else {
          animate2.value = false;
        }
          if (value['status'] == 'Error') {
            dialogError(value['messages']);
          } else {
            dialogSuccess(value['messages'], () => Get.back());
          }
        });
      }
    } catch (e) {
      if (keyword == 'masuk') {
          animate1.value = false;
        } else {
          animate2.value = false;
        }
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
      
      LemburProvider()
          .getHariIni(dataUser['access_token'], dataUser['nip'])
          .then((value) {
        final data = value.body;

        DateTime datetimeMulai = DateTime.fromMillisecondsSinceEpoch(
            data['data']['time_jam_mulai'] * 1000);
        DateTime oneHourOld = datetimeMulai.subtract(const Duration(hours: 1));
        int newTimestampOld = oneHourOld.millisecondsSinceEpoch ~/ 1000;

        DateTime datetimeSelesai = DateTime.fromMillisecondsSinceEpoch(
            data['data']['time_jam_selesai'] * 1000);
        DateTime oneHourLater = datetimeSelesai.add(const Duration(hours: 1));
        int newTimestampLater = oneHourLater.millisecondsSinceEpoch ~/ 1000;

        final now = DateFormat('yyyy-MM-dd').format(DateTime.now());
        if (data['data']['tanggal_ymd'] == now &&
            DateTime.now().millisecondsSinceEpoch / 1000 > newTimestampOld &&
            DateTime.now().millisecondsSinceEpoch / 1000 < newTimestampLater) {
          id.value = data['data']['id'].toString();
          lembur.value = true;
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
      double distanceInMeters = calculateDistance(
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
