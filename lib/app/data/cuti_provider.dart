import 'package:get/get.dart';
import 'package:absensisbc/app/constant/api_const.dart';
import 'package:get_storage/get_storage.dart';

class CutiProvider extends GetConnect {
  var dataUser = GetStorage().read('dataUser');
  Future<Response> getMasterCuti(String token) {
    return get('${BASEAPI}pengajuan/cuti', headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    });
  }

  Future<List<dynamic>> getLists(String token, String nip, String page) async {
    final response = await get(
        BASEAPI + 'pengajuan/cuti/lists?nip=' + nip + "&page=" + page,
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

  Future<Response> postCuti(
    String token,
    String nip,
    String tanggalMulai,
    String tanggalSelesai,
    String kodeCuti,
    String keterangan,
    String image,
  ) {
    final body = {
      'nip': nip,
      'kode_cuti': kodeCuti,
      'tanggal_mulai': tanggalMulai,
      'tanggal_selesai': tanggalSelesai,
      'keterangan': keterangan,
      'file': image,
    };

    return post('${BASEAPI}pengajuan/cuti/store', body, headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    });
  }

  Future<Response> getRekap(String nip) {
    return get('${BASEAPI}pengajuan/cuti/tahunan?nip=$nip', headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer ${dataUser['access_token']}"
    });
  }
}
