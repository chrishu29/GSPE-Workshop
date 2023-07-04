class RepairList {
  final int id;
  final String rmaNum;
  final String customerName;
  final String siteName;
  final int duration;
  final String dateIn;
  final String partName;
  final String partNum;
  final String partDesc;
  final String mfr;
  final String serialNum;
  final int repairStatus;

  RepairList({
    required this.id,
    required this.rmaNum,
    required this.customerName,
    required this.siteName,
    required this.duration,
    required this.dateIn,
    required this.partName,
    required this.partNum,
    required this.partDesc,
    required this.mfr,
    required this.serialNum,
    required this.repairStatus,
  });

  factory RepairList.fromJson(Map<String, dynamic> json) => RepairList(
        id: json["id"],
        rmaNum: json["rma_num"],
        customerName: json["customer_name"],
        siteName: json["site_name"],
        duration: json["duration"],
        dateIn: json["date_in"],
        partName: json["part_name"],
        partNum: json["part_num"],
        partDesc: json["part_desc"],
        mfr: json["mfr"],
        serialNum: json["serial_num"],
        repairStatus: json["repair_status"],
      );

  RepairList.empty()
      : id = 0,
        rmaNum = '',
        customerName = '',
        siteName = '',
        duration = 0,
        dateIn = '',
        partName = '',
        partNum = '',
        partDesc = '',
        mfr = '',
        serialNum = '',
        repairStatus = 0;
}
