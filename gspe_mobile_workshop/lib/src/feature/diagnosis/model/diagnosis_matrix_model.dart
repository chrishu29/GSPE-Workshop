class DiagnosisMatrix {
  final int id;
  final String name;
  final String level;
  final int duration;
  final String created_at;
  final String updated_at;

  DiagnosisMatrix({
    required this.id,
    required this.name,
    required this.level,
    required this.duration,
    required this.created_at,
    required this.updated_at,
  });

  factory DiagnosisMatrix.fromJson(Map<String, dynamic> json) =>
      DiagnosisMatrix(
        id: json["id"],
        name: json["name"],
        level: json["level"],
        duration: json["duration"],
        created_at: json["created_at"],
        updated_at: json["updated_at"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['level'] = this.level;
    data['duration'] = this.duration;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    return data;
  }
}
