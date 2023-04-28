import 'package:get/get.dart';
import 'package:absensisbc/app/constant/api_const.dart';

class PayslipProvider extends GetConnect {
  Future<List<dynamic>> getLists(String token, String nip, String page) async {
    final response = await get("${BASEAPI}payroll?nip=$nip&page=$page",
        headers: {
          'Accept': 'application/json',
          'Authorization': "Bearer $token"
        });
    if (response.status.hasError) {
      return Future.error({'error': response.statusText});
    } else {
      return response.body;
    }
  }
}
