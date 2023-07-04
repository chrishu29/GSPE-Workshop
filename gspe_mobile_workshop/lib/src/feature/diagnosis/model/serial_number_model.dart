class SerialNumber {
  final int rmaDetailId;
  final String rmaNum;
  final String customerName;
  final String siteName;
  final String dateIn;
  final String partName;
  final String partNum;
  final String partDesc;
  final String mfr;
  final String serialNum;
  final int productId;

  SerialNumber({
    required this.rmaDetailId,
    required this.rmaNum,
    required this.customerName,
    required this.siteName,
    required this.dateIn,
    required this.partName,
    required this.partNum,
    required this.partDesc,
    required this.mfr,
    required this.serialNum,
    required this.productId,
  });

  factory SerialNumber.fromJson(Map<String, dynamic> json) => SerialNumber(
        rmaDetailId: json["rma_detail_id"],
        rmaNum: json["rma_num"],
        customerName: json["customer_name"],
        siteName: json["site_name"],
        dateIn: json["date_in"],
        partName: json["part_name"],
        partNum: json["part_num"],
        partDesc: json["part_desc"],
        mfr: json["mfr"],
        serialNum: json["serial_num"],
        productId: json["product_id"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rma_detail_id'] = this.rmaDetailId;
    data['rma_num'] = this.rmaNum;
    data['customer_name'] = this.customerName;
    data['site_name'] = this.siteName;
    data['date_in'] = this.dateIn;
    data['part_name'] = this.partName;
    data['part_num'] = this.partNum;
    data['part_desc'] = this.partDesc;
    data['mfr'] = this.mfr;
    data['serial_num'] = this.serialNum;
    data['product_id'] = this.productId;
    return data;
  }
}
