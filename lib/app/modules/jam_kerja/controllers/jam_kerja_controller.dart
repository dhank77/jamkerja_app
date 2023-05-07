import 'dart:math';

import 'package:jamkerja/app/data/presensi_provider.dart';
import 'package:get/get.dart';

class JamKerjaController extends GetxController {
  final List<dynamic> listData = [].obs;
  final List<dynamic> listDataStatis = [].obs;
  final List<dynamic> listMaster = [].obs;
  final jamKerja = {}.obs;
  var bulan = DateTime.now().month.obs;
  var tahun = DateTime.now().year.obs;

  void getDataStatis() {
    listData.clear();
    try {
      PresensiProvider().getJamKerjaStatis().then((resp) {
        listDataStatis.addAll(resp);
      }, onError: (err) {
        print(err);
      });
    } catch (exception) {
      print(e);
    }
  }

  void getData() {
    listData.clear();
    try {
      PresensiProvider()
          .getCalender(
        bulan.value.toString(),
        tahun.value.toString(),
      )
          .then((resp) {
        listData.addAll(resp);
      }, onError: (err) {
        print(err);
      });
    } catch (exception) {
      print(e);
    }
  }

  void getMasterJadwal() {
    listMaster.clear();
    try {
      PresensiProvider().getMasterJadwal().then((resp) {
        listMaster.addAll(resp);
      }, onError: (err) {
        print(err);
      });
    } catch (exception) {
      print(e);
    }
  }

  void getJamKerja() {
    try {
      PresensiProvider().getJamKerja().then((resp) {
        if (resp.body != null) {
          jamKerja.addAll(resp.body);
          if (resp.body['keterangan'] != 'statis') {
            getData();
            getMasterJadwal();
          } else {
            getDataStatis();
          }
        }
      }, onError: (err) {
        print(err);
      });
    } catch (exception) {
      print(e);
    }
  }

  void changeMonthMin() {
    if (bulan.value - 1 == 0) {
      bulan.value = 12;
      tahun.value -= 1;
    } else {
      bulan.value -= 1;
    }
    getData();
  }

  void changeMonthPlus() {
    if (bulan.value + 1 == 13) {
      bulan.value = 1;
      tahun.value += 1;
    } else {
      bulan.value += 1;
    }
    getData();
  }

  @override
  void onInit() {
    getJamKerja();
    getMasterJadwal();
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
