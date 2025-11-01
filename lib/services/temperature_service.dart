import '../models/temperature_model.dart';

class TemperatureService {
  final List<TemperatureModel> _temperatureRecords = [];

  // Add new temperature record
  void saveTemperature(TemperatureModel record) {
    _temperatureRecords.add(record);
  }

  // Retrieve all records
  List<TemperatureModel> getTemperatureRecords() {
    return List.unmodifiable(_temperatureRecords.reversed);
  }

  // Delete a specific record
  void deleteTemperature(int index) {
    if (index >= 0 && index < _temperatureRecords.length) {
      _temperatureRecords.removeAt(index);
    }
  }

  // Clear all records
  void clearAll() {
    _temperatureRecords.clear();
  }
}
