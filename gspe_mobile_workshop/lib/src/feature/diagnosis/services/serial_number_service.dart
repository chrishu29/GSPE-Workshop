import 'dart:convert';
import 'package:gspe_mobile_workshop/src/feature/diagnosis/model/serial_number_model.dart';
import 'package:http/http.dart' as http;

class SerialNumberService {
  Future<List<SerialNumber>> getAll() async {
    const _baseUrl = 'http://workshop.iotech.my.id/api/search-rma-serial';
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final dMatrix = json.map((e) {
        return SerialNumber.fromJson(e);
      }).toList();
      return dMatrix;
    }
    throw "Can't Fetch Data !";
  }
}
