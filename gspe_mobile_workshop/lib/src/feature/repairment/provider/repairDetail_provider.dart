import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/feature/repairment/model/rapairList_model.dart';
import 'package:gspe_mobile_workshop/src/feature/repairment/model/repairDetail_model.dart';
import 'package:gspe_mobile_workshop/src/feature/repairment/provider/repairList_provider.dart';
import 'package:gspe_mobile_workshop/src/feature/repairment/service/repairDetail_service.dart';

class RepairDetailProvider extends ChangeNotifier {
  final _service = RepairDetailService();
  final _repairList = RepairListProvider();
  List<RepairDetail> _repairDetailData = [];
  List<RepairDetail> get Data => _repairDetailData;

  String _selectedRepairSerial = '';
  String get selectedRepairSerial => _selectedRepairSerial;

  void setSelectedRepairSerial(String serial) {
    _selectedRepairSerial = serial;
    notifyListeners();
  }

  Future<void> getAllData() async {
    await _repairList.getAllData();
    final repairListData = _repairList.Data;
    final selectedRepairData = repairListData.firstWhere(
      (serial) => serial.serialNum == _selectedRepairSerial,
      orElse: () => RepairList.empty(),
    );
    final repairDetailId = selectedRepairData.id;

    final response = await _service.getAll(repairDetailId);

    _repairDetailData = response;
    notifyListeners();
  }
}
