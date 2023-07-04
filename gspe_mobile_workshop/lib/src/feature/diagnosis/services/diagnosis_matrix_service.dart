import 'dart:convert';
import 'package:gspe_mobile_workshop/src/feature/diagnosis/model/diagnosis_matrix_model.dart';
import 'package:http/http.dart' as http;

class DiagnosisMatrixService {
  Future<List<DiagnosisMatrix>> getAll() async {
    const _baseUrl = 'http://workshop.iotech.my.id/api/diagnosis-matrix';
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final dMatrix = json.map((e) {
        return DiagnosisMatrix.fromJson(e);
      }).toList();
      return dMatrix;
    }
    throw "Can't Fetch Data !";
  }
}
