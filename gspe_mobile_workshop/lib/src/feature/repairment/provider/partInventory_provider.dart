import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/feature/repairment/model/partInventory_model.dart';
import 'package:gspe_mobile_workshop/src/feature/repairment/service/partInventory_service.dart';

class PartInventoryProvider extends ChangeNotifier {
  final _service = PartInventoryService();
  List<PartInventory> _allData = [];
  List<PartInventory> get allData => _allData;
  List<String> _suggestions = [];
  List<String> get suggestions => _suggestions;

  Future<void> getAllData() async {
    final response = await _service.getAll();
    _allData = response;
    // Initialize suggestions with all serial numbers
    _suggestions = _allData.map((item) => item.partName).toList();
    // print(suggestions.length);
    notifyListeners();
  }

  List<String> getSuggestions(String query) {
    if (query.isEmpty) {
      return []; // Return an empty list when the query is empty
    }
    return _suggestions
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
