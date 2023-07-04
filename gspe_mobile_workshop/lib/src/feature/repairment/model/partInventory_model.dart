class PartInventory {
  final int id;
  final String mfr;
  final String partNum;
  final String partName;
  final String partDesc;
  final int qty;
  final String defaultUm;

  PartInventory({
    required this.id,
    required this.mfr,
    required this.partNum,
    required this.partName,
    required this.partDesc,
    required this.qty,
    required this.defaultUm,
  });

  factory PartInventory.fromJson(Map<String, dynamic> json) => PartInventory(
        id: json["id"],
        mfr: json["mfr"],
        partNum: json["part_num"],
        partName: json["part_name"],
        partDesc: json["part_desc"],
        qty: json["qty"],
        defaultUm: json["default_um"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mfr": mfr,
        "part_num": partNum,
        "part_name": partName,
        "part_desc": partDesc,
        "qty": qty,
        "default_um": defaultUm,
      };
}
