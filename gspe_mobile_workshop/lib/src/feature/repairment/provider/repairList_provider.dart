import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/feature/repairment/model/rapairList_model.dart';
import 'package:gspe_mobile_workshop/src/feature/repairment/service/rapairList_service.dart';

class RepairListProvider extends ChangeNotifier {
  final _service = RepairListService(); //initiate & call service class
  List<RepairList> _data = []; // list for all Data
  List<RepairList> get Data => _data;

  Future<void> getAllData() async {
    final response = await _service.getAll();

    _data = response;
    notifyListeners();
  }
}
