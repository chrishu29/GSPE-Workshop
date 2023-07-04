class FaultyMatrix {
  final int id;
  final int rmaDetailId;
  final int duration;
  final int diagnosisMatrixId;
  final String remark;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Desc desc;

  FaultyMatrix({
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

  factory FaultyMatrix.fromJson(Map<String, dynamic> json) => FaultyMatrix(
        id: json["id"],
        rmaDetailId: json["rma_detail_id"],
        duration: json["duration"],
        diagnosisMatrixId: json["diagnosis_matrix_id"],
        remark: json["remark"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        desc: Desc.fromJson(json["desc"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rma_detail_id": rmaDetailId,
        "duration": duration,
        "diagnosis_matrix_id": diagnosisMatrixId,
        "remark": remark,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "desc": desc.toJson(),
      };
}

class Desc {
  final int id;
  final String name;
  final String level;
  final int duration;
  final DateTime createdAt;
  final DateTime updatedAt;

  Desc({
    required this.id,
    required this.name,
    required this.level,
    required this.duration,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Desc.fromJson(Map<String, dynamic> json) => Desc(
        id: json["id"],
        name: json["name"],
        level: json["level"],
        duration: json["duration"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "level": level,
        "duration": duration,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
