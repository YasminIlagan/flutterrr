class HealthDataModel {
  final double value;
  final DateTime measuredAt;
  final String source;

  HealthDataModel({
    required this.value,
    required this.measuredAt,
    required this.source,
  });

  factory HealthDataModel.fromJson(Map<String, dynamic> json) {
    return HealthDataModel(
      value: (json['value'] ?? 0).toDouble(),
      measuredAt: DateTime.parse(json['measuredAt']),
      source: json['source'] ?? 'manual',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'measuredAt': measuredAt.toIso8601String(),
      'source': source,
    };
  }
}
