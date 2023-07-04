import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/feature/diagnosis/model/serial_number_model.dart';
import 'package:gspe_mobile_workshop/src/feature/diagnosis/services/serial_number_service.dart';

class SerialNumProvider extends ChangeNotifier {
  final _service = SerialNumberService();
  List<SerialNumber> _allData = [];
  List<SerialNumber> get allData => _allData;
  List<String> _suggestions = [];
  List<String> get suggestions => _suggestions;

  Future<void> getAllData() async {
    final response = await _service.getAll();
    _allData = response;
    // Initialize suggestions with all serial numbers
    _suggestions = _allData.map((item) => item.serialNum).toList();
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
