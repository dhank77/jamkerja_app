import 'package:get/get.dart';
import 'package:absensisbc/app/constant/api_const.dart';

class ShiftProvider extends GetConnect {
  Future<Response> getMasterShift(String token) {
    return get(BASEAPI + 'pengajuan/shift', headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    });
  }

  Future<List<dynamic>> getLists(String token, String nip, String page) async {
    final response = await get(
        BASEAPI + 'pengajuan/shift/lists?nip=' + nip + "&page=" + page,
        headers: {
          'Accept': 'application/json',
          'Authorization': "Bearer $token"
        });

    if (response.status.hasError) {
      return Future.error({'error': response.statusText});
    } else {
      return response.body['data'];
    }
  }

  Future<Response> postShift(
    String token,
    String nip,
    String kodeShift,
    String keterangan,
  ) {
    final body = {
      'nip': nip,
      'kode_shift': kodeShift,
      'keterangan': keterangan,
    };

    return post(BASEAPI + 'pengajuan/shift/store', body, headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    });
  }
}
