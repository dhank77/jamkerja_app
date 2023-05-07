import 'package:get/get.dart';
import 'package:jamkerja/app/constant/api_const.dart';

class PerusahaanProvider extends GetConnect {
  Future<Response> getData(String token) {
    return get(BASEAPI + 'perusahaan', headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    });
  }
}
