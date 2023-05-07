import 'package:get/get.dart';
import 'package:jamkerja/app/constant/api_const.dart';

class ReimbursementProvider extends GetConnect {
  Future<Response> getMasterReimbursement(String token) {
    return get(BASEAPI + 'pengajuan/reimbursement', headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    });
  }

  Future<List<dynamic>> getLists(String token, String nip, String page) async {
    final response = await get(
        BASEAPI + 'pengajuan/reimbursement/lists?nip=' + nip + "&page=" + page,
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

  Future<Response> postReimbursement(
    String token,
    String nip,
    String nilai,
    String kodeReimbursement,
    String keterangan,
  ) {
    final body = {
      'nip': nip,
      'kode_reimbursement': kodeReimbursement,
      'nilai': nilai,
      'keterangan': keterangan,
    };

    return post(BASEAPI + 'pengajuan/reimbursement/store', body, headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    });
  }
}
