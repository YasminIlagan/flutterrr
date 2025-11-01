class TemperatureModel {
  final double temperature;
  final String unit;
  final String classification;
  final DateTime measuredAt;

  TemperatureModel({
    required this.temperature,
    required this.unit,
    required this.classification,
    required this.measuredAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'temperature': temperature,
      'unit': unit,
      'classification': classification,
      'measuredAt': measuredAt.toIso8601String(),
    };
  }

  factory TemperatureModel.fromMap(Map<String, dynamic> map) {
    return TemperatureModel(
      temperature: (map['temperature'] ?? 0).toDouble(),
      unit: map['unit'] ?? 'Celsius',
      classification: map['classification'] ?? 'Normal',
      measuredAt: DateTime.parse(map['measuredAt']),
    );
  }
}
