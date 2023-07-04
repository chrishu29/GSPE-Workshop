class RepairDetail {
  int id;
  int rmaId;
  int productId;
  String serialNum;
  int qty;
  String complain;
  int warrantyStatus;
  String createdAt;
  String updatedAt;
  dynamic diagnosisMatrix;
  int diagnosisStatus;
  dynamic diagnosisBy;
  int duration;
  String diagnosisDate;
  dynamic diagnosisPic;
  dynamic diagnosisNote;
  String repairPic;
  dynamic repairNote;
  int repairStatus;
  int isRepairable;
  dynamic repairStartDate;
  dynamic repairEndDate;
  Products products;
  Rma rma;
  List<MatrixDiagnosis> matrixDiagnosis;
  List<dynamic> itemReplace;

  RepairDetail({
    required this.id,
    required this.rmaId,
    required this.productId,
    required this.serialNum,
    required this.qty,
    required this.complain,
    required this.warrantyStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.diagnosisMatrix,
    required this.diagnosisStatus,
    required this.diagnosisBy,
    required this.duration,
    required this.diagnosisDate,
    required this.diagnosisPic,
    required this.diagnosisNote,
    required this.repairPic,
    required this.repairNote,
    required this.repairStatus,
    required this.isRepairable,
    required this.repairStartDate,
    required this.repairEndDate,
    required this.products,
    required this.rma,
    required this.matrixDiagnosis,
    required this.itemReplace,
  });

  factory RepairDetail.fromJson(Map<String, dynamic> json) {
    return RepairDetail(
      id: json['repair_detail']['id'] ?? 0,
      rmaId: json['repair_detail']['rma_id'] ?? 0,
      productId: json['repair_detail']['product_id'] ?? 0,
      serialNum: json['repair_detail']['serial_num'] ?? '-',
      qty: json['repair_detail']['qty'] ?? 0,
      complain: json['repair_detail']['complain'] ?? '-',
      warrantyStatus: json['repair_detail']['warranty_status'] ?? 0,
      createdAt: json['repair_detail']['created_at'] ?? '-',
      updatedAt: json['repair_detail']['updated_at'] ?? '-',
      diagnosisMatrix: json['repair_detail']['diagnosis_matrix'] ?? null,
      diagnosisStatus: json['repair_detail']['diagnosis_status'] ?? 0,
      diagnosisBy: json['repair_detail']['diagnosis_by'] ?? null,
      duration: json['repair_detail']['duration'] ?? 0,
      diagnosisDate: json['repair_detail']['diagnosis_date'] ?? '-',
      diagnosisPic: json['repair_detail']['diagnosis_pic'] ?? null,
      diagnosisNote: json['repair_detail']['diagnosis_note'] ?? null,
      repairPic: json['repair_detail']['repair_pic'] ?? '-',
      repairNote: json['repair_detail']['repair_note'] ?? null,
      repairStatus: json['repair_detail']['repair_status'] ?? 0,
      isRepairable: json['repair_detail']['is_repairable'] ?? 0,
      repairStartDate: json['repair_detail']['repair_start_date'] ?? null,
      repairEndDate: json['repair_detail']['repair_end_date'] ?? null,
      products: Products.fromJson(json['repair_detail']['products']),
      rma: Rma.fromJson(json['repair_detail']['rma']),
      matrixDiagnosis: List<MatrixDiagnosis>.from(
          json['matrix_diagnosis'].map((x) => MatrixDiagnosis.fromJson(x))),
      itemReplace: json['item_repalce'] ?? [],
    );
  }
}

class Products {
  int id;
  String mfr;
  String categoryPartNum;
  String partNum;
  String partName;
  String partDesc;
  String defaultUm;
  String altUm;
  String defaultCurr;
  String unitCost;
  String sellPrice;
  int breakDownPrice;
  String itemPrice;
  String priceDate;
  String leadTime;
  String priceValidUntil;
  int itemNeedQc;
  int productType;
  int width;
  int weight;
  int volume;
  String status;
  int hidden;
  dynamic createdBy;
  dynamic modifiedBy;
  String createdAt;
  String updatedAt;
  String prodID;
  int type;

  Products({
    required this.id,
    required this.mfr,
    required this.categoryPartNum,
    required this.partNum,
    required this.partName,
    required this.partDesc,
    required this.defaultUm,
    required this.altUm,
    required this.defaultCurr,
    required this.unitCost,
    required this.sellPrice,
    required this.breakDownPrice,
    required this.itemPrice,
    required this.priceDate,
    required this.leadTime,
    required this.priceValidUntil,
    required this.itemNeedQc,
    required this.productType,
    required this.width,
    required this.weight,
    required this.volume,
    required this.status,
    required this.hidden,
    required this.createdBy,
    required this.modifiedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.prodID,
    required this.type,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'] ?? 0,
      mfr: json['mfr'] ?? '-',
      categoryPartNum: json['category_part_num'] ?? '-',
      partNum: json['part_num'] ?? '-',
      partName: json['part_name'] ?? '-',
      partDesc: json['part_desc'] ?? '-',
      defaultUm: json['default_um'] ?? '-',
      altUm: json['alt_um'] ?? '',
      defaultCurr: json['default_curr'] ?? '-',
      unitCost: json['unit_cost'] ?? 0.0,
      sellPrice: json['sell_price'] ?? '0',
      breakDownPrice: json['break_down_price'] ?? 0,
      itemPrice: json['item_price'] ?? 0.0,
      priceDate: json['price_date'] ?? '-',
      leadTime: json['lead_time'] ?? '-',
      priceValidUntil: json['price_valid_until'] ?? '-',
      itemNeedQc: json['item_need_qc'] ?? 0,
      productType: json['product_type'] ?? 0,
      width: json['width'] ?? 0,
      weight: json['weight'] ?? 0,
      volume: json['volume'] ?? 0,
      status: json['status'] ?? '-',
      hidden: json['hidden'] ?? 0,
      createdBy: json['created_by'] ?? null,
      modifiedBy: json['modified_by'] ?? null,
      createdAt: json['created_at'] ?? '-',
      updatedAt: json['updated_at'] ?? '-',
      prodID: json['ProdID'] ?? '-',
      type: json['type'] ?? 0,
    );
  }
}

class Rma {
  int id;
  String rmaNum;
  String rmaNumSeq;
  int docId;
  String entityType;
  String entityName;
  String customerName;
  String dateIn;
  String siteName;
  int status;
  String createdAt;
  String updatedAt;

  Rma({
    required this.id,
    required this.rmaNum,
    required this.rmaNumSeq,
    required this.docId,
    required this.entityType,
    required this.entityName,
    required this.customerName,
    required this.dateIn,
    required this.siteName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Rma.fromJson(Map<String, dynamic> json) {
    return Rma(
      id: json['id'] ?? 0,
      rmaNum: json['rma_num'] ?? '-',
      rmaNumSeq: json['rma_num_seq'] ?? '-',
      docId: json['doc_id'] ?? 0,
      entityType: json['entity_type'] ?? '-',
      entityName: json['entity_name'] ?? '-',
      customerName: json['customer_name'] ?? '-',
      dateIn: json['date_in'] ?? '-',
      siteName: json['site_name'] ?? '-',
      status: json['status'] ?? 0,
      createdAt: json['created_at'] ?? '-',
      updatedAt: json['updated_at'] ?? '-',
    );
  }
}

class MatrixDiagnosis {
  int id;
  int rmaDetailId;
  int duration;
  int diagnosisMatrixId;
  String remark;
  int status;
  String createdAt;
  String updatedAt;
  Desc desc;

  MatrixDiagnosis({
    required this.id,
    required this.rmaDetailId,
    required this.duration,
    required this.diagnosisMatrixId,
    required this.remark,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.desc,
  });

  factory MatrixDiagnosis.fromJson(Map<String, dynamic> json) {
    return MatrixDiagnosis(
      id: json['id'] ?? 0,
      rmaDetailId: json['rma_detail_id'] ?? 0,
      duration: json['duration'] ?? 0,
      diagnosisMatrixId: json['diagnosis_matrix_id'] ?? 0,
      remark: json['remark'] ?? '-',
      status: json['status'] ?? 0,
      createdAt: json['created_at'] ?? '-',
      updatedAt: json['updated_at'] ?? '-',
      desc: Desc.fromJson(json['desc']),
    );
  }
}

class Desc {
  int id;
  String name;
  String level;
  int duration;
  String createdAt;
  String updatedAt;

  Desc({
    required this.id,
    required this.name,
    required this.level,
    required this.duration,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Desc.fromJson(Map<String, dynamic> json) {
    return Desc(
      id: json['id'] ?? 0,
      name: json['name'] ?? '-',
      level: json['level'] ?? '-',
      duration: json['duration'] ?? 0,
      createdAt: json['created_at'] ?? '-',
      updatedAt: json['updated_at'] ?? '-',
    );
  }
}
