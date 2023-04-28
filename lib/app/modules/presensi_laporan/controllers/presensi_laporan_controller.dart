import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:absensisbc/app/data/presensi_provider.dart';
import 'package:intl/intl.dart';

class PresensiLaporanController extends GetxController {
  var listData = List<dynamic>.empty(growable: true).obs;
  final picked = ''.obs;
  final pickedStart = DateFormat('dd-MM-yyyy')
      .format(DateTime.now().subtract(Duration(days: 7)))
      .toString()
      .obs;
  final pickedEnd =
      DateFormat('dd-MM-yyyy').format(DateTime.now()).toString().obs;
  var dataUser = GetStorage().read('dataUser');

  void getLaporan() {
    listData.clear();
    PresensiProvider()
        .getPresensi(dataUser['nip'], dataUser['access_token'],
            pickedStart.value, pickedEnd.value)
        .then((value) {
      listData.addAll(value);
    }, onError: (err) {
      print(err);
    });
  }

  Future<void> refreshData() async {
    listData.clear();
    getLaporan();
  }

  @override
  void onInit() {
    super.onInit();
    getLaporan();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
