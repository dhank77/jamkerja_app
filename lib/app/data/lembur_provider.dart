import 'package:get/get.dart';
import 'package:jamkerja/app/constant/api_const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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

    return post('${BASEAPI}pengajuan/lembur/store', body, headers: {
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

   Future<Response> getHariIni(String token, String nip) {
    return get('${BASEAPI}pengajuan/lembur/getHariIni?nip=$nip', headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    });
  }

   Future<Map<String, dynamic>> presensi(
    String nip,
    String token,
    String id,
    String kordinat,
    String field,
  ) async {
    final body = {
      'nip': nip,
      'field': field,
      'kordinat': kordinat,
      'date': DateTime.now().toString(),
      'timezone': DateTime.now().toLocal().timeZoneName.toString(),
      'id': id,
    };

    var headers = {
      'Authorization': "Bearer $token",
      'Accept': 'application/json',
    };
    var url = Uri.http(BASELINK, 'api/pengajuan/presensi');
    var response = await http.post(url, body: body, headers: headers);

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    return jsonResponse;
  }
}
