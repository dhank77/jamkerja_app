import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jamkerja/app/constant/api_const.dart';

class PerusahaanProvider extends GetConnect {
    var dataUser = GetStorage().read('dataUser');
    
  Future<Response> getData(String token, String kodePerusahaan) {
    return get("${BASEAPI}perusahaan?kode_perusahaan=$kodePerusahaan", headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    });
  }
}
