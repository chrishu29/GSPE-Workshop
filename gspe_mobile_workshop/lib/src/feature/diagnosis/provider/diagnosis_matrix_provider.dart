import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/feature/diagnosis/model/diagnosis_matrix_model.dart';
import 'package:gspe_mobile_workshop/src/feature/diagnosis/services/diagnosis_matrix_service.dart';

class DiagMatrixProvider extends ChangeNotifier {
  final _service = DiagnosisMatrixService(); //initiate & call service class
  List<DiagnosisMatrix> _allData = []; // list for all Data
  List<DiagnosisMatrix> get allData => _allData;

  Future<void> getAllData() async {
    final response = await _service.getAll();

    _allData = response;
    notifyListeners();
  }
}
