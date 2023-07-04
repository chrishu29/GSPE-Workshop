import 'dart:convert';
import 'package:gspe_mobile_workshop/src/feature/repairment/model/rapairList_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RepairListService {
  Future<List<RepairList>> getAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _storedResponse = prefs.getString('apiResponse');
    int empId = 0;
    if (_storedResponse != null) {
      Map<String, dynamic> jsonResponse = jsonDecode(_storedResponse);
      empId = jsonResponse['emp_id'] as int;
      // Use the empId value as needed
    }
    String _baseUrl = 'http://workshop.iotech.my.id/api/repair-list/$empId';
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final rList = json.map((e) {
        final repairList = RepairList.fromJson(e);
        return repairList;
      }).toList();
      return rList;
    } else {
      print(response.statusCode);
      throw Exception('Failed to fetch data');
    }
  }
}
