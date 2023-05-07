import 'package:get/get.dart';
import 'package:jamkerja/app/constant/api_const.dart';

class LemburProvider extends GetConnect {
  Future<Response> postLembur(
    String token,
    String nip,
    String tanggal,
    String jamMulai,
    String jamSelesai,
    String keterangan,
    String image,
  ) {
    final body = {
      'nip': nip,
      'tanggal': tanggal,
      'jam_mulai': jamMulai,
      'jam_selesai': jamSelesai,
      'keterangan': keterangan,
      'file': image,
    };

    return post(BASEAPI + 'pengajuan/lembur/store', body, headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    });
  }

  Future<List<dynamic>> getLists(String token, String nip, String page) async {
    final response = await get(
        BASEAPI + 'pengajuan/lembur/lists?nip=' + nip + "&page=" + page,
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
}
