class DiagnosisModule {
  String description;
  int duration;
  String remarks;
  int matrixId;
  int? repairStatus;

  DiagnosisModule(
      {required this.description,
      required this.duration,
      required this.remarks,
      required this.matrixId,
      this.repairStatus});
}
