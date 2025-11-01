import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/health_data_model.dart';

class SugarLevelService {
  static const String _storageKey = 'sugar_level_data';

  static Future<void> saveSugarLevelData({
    required double sugarLevel,
    required DateTime measuredAt,
    required String source,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final existingData = prefs.getStringList(_storageKey) ?? [];

    final newData = HealthDataModel(
      value: sugarLevel,
      measuredAt: measuredAt,
      source: source,
    );

    existingData.insert(0, jsonEncode(newData.toJson())); // newest first
    await prefs.setStringList(_storageKey, existingData);
  }

  static Future<List<HealthDataModel>> getSugarLevelData({int days = 7}) async {
    final prefs = await SharedPreferences.getInstance();
    final existingData = prefs.getStringList(_storageKey) ?? [];

    final cutoffDate = DateTime.now().subtract(Duration(days: days));

    return existingData
        .map((e) => HealthDataModel.fromJson(jsonDecode(e)))
        .where((entry) => entry.measuredAt.isAfter(cutoffDate))
        .toList();
  }

  static Future<void> clearSugarLevelData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}
