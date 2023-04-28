import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:absensisbc/app/data/perusahaan_provider.dart';

class MenuPerusahaanController extends GetxController {
  var perusahaan = List<dynamic>.empty(growable: true).obs;
  var dataUser = GetStorage().read('dataUser');

  void getData() {
    try {
      PerusahaanProvider().getData(dataUser['access_token']).then((resp) {
        perusahaan.add(resp.body['data']);
      });
    } catch (exception) {
      print(exception);
    }
  }

  @override
  void onInit() {
    getData();
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
