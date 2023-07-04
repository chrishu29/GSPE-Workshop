import 'dart:convert';
import 'package:gspe_mobile_workshop/src/feature/repairment/model/partInventory_model.dart';
import 'package:http/http.dart' as http;

class PartInventoryService {
  Future<List<PartInventory>> getAll() async {
    const _baseUrl = 'http://workshop.iotech.my.id/api/workshop-inventory';
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final partInven = json.map((e) {
        return PartInventory.fromJson(e);
      }).toList();
      return partInven;
    }
    throw "Can't Fetch Data !";
  }
}
