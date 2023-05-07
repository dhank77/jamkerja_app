import 'package:get/get.dart';
import 'package:jamkerja/app/constant/api_const.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class VisitProvider extends GetConnect {
  Future<Response> getData(
      String token, String nip, String mulai, String selesai) {
    return get('${BASEAPI}visit?nip=$nip&mulai=$mulai&selesai=$selesai',
        headers: {
          'Accept': 'application/json',
          'Authorization': "Bearer $token"
        });
  }

  Future<Response> getLokasi(String token, String kodeVisit) {
    return get('${BASEAPI}visit/lokasi?kode=$kodeVisit', headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    });
  }

  Future<Response> postData(
    String nip,
    String token,
    String kordinat,
    String kodeVisit,
    String image,
  ) {
    final body = {
      'nip': nip,
      'kordinat': kordinat,
      'kode_visit': kodeVisit,
      'timezone': DateTime.now().toLocal().timeZoneName.toString(),
      'image': image,
    };

    return post('${BASEAPI}visit/store', body, headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    });
  }

  Future<Map<String, dynamic>> saveData(
    String token,
    String nip,
    String judul,
    String keterangan,
    String image,
    String kordinat,
    String lokasi,
  ) async {
    final body = {
      'nip': nip,
      'judul': judul,
      'kordinat': kordinat,
      'lokasi': lokasi,
      'keterangan': keterangan,
      'image': image,
    };

    var headers = {
      'Authorization': "Bearer $token",
      'Accept': 'application/json',
    };
    var url = Uri.http(BASELINK, 'api/visit/store-new');
    var response = await http.post(url, body: body, headers: headers);

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    return jsonResponse;
  }
}
