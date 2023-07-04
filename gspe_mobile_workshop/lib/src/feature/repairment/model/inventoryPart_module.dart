class PartModule {
  int id;
  String mfr;
  String partNum;
  String partName;
  String partDesc;
  int qty;
  int reqQty;
  String defaultUm;

  PartModule({
    required this.id,
    required this.mfr,
    required this.partNum,
    required this.partName,
    required this.partDesc,
    required this.qty,
    required this.reqQty,
    required this.defaultUm,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mfr': mfr,
      'partNum': partNum,
      'partName': partName,
      'partDesc': partDesc,
      'defaultUm': defaultUm,
      'qty': qty,
      'reqQty': reqQty,
    };
  }
}
