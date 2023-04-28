import 'package:get/get.dart';
import 'package:absensisbc/app/constant/api_const.dart';

class PengumumanProvider extends GetConnect {
  Future<List<dynamic>> getLists(String token, String page) async {
    final response = await get('${BASEAPI}pengumuman?page=$page', headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    });

    if (response.status.hasError) {
      return Future.error({'error': response.statusText});
    } else {
      return response.body['data'];
    }
  }
}
