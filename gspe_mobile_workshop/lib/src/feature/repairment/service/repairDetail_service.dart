import 'dart:convert';
import 'package:gspe_mobile_workshop/src/feature/repairment/model/repairDetail_model.dart';
import 'package:http/http.dart' as http;

class RepairDetailService {
  Future<List<RepairDetail>> getAll(int repairDetailId) async {
    String _baseUrl =
        'http://workshop.iotech.my.id/api/repair-detail/$repairDetailId';
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final rDetail = json.map((e) {
        final repairDetail = RepairDetail.fromJson(e);
        return repairDetail;
      }).toList();
      return rDetail;
    } else {
      print(response.statusCode);
      throw Exception('Failed to fetch data');
    }
  }
}
