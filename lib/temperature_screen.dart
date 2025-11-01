import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TemperatureScreen extends StatefulWidget {
  const TemperatureScreen({super.key});

  @override
  State<TemperatureScreen> createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  final TextEditingController _tempController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _selectedUnit = 'Celsius';

  List<Map<String, dynamic>> _records = [];

  double _getResponsiveFontSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 375;
    final clampedScaleFactor = scaleFactor.clamp(0.8, 1.4);
    return baseSize * clampedScaleFactor;
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF73C2FF),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF73C2FF),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  void _saveTemperature() {
    if (!_formKey.currentState!.validate()) return;

    final double temp = double.parse(_tempController.text);
    final DateTime dateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    setState(() {
      _records.insert(0, {
        'temp': temp,
        'unit': _selectedUnit,
        'datetime': dateTime,
      });
      _tempController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Temperature saved successfully!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  String _getClassification(double temp, String unit) {
    double celsius = unit == 'Fahrenheit' ? (temp - 32) * 5 / 9 : temp;

    if (celsius < 36) return 'Low';
    if (celsius > 37.5) return 'High';
    return 'Normal';
  }

  Color _getClassificationColor(String classification) {
    switch (classification) {
      case 'Low':
        return Colors.blue;
      case 'High':
        return Colors.red;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFDEDEDE),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: screenWidth * 0.12,
                      height: screenWidth * 0.12,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.black54),
                    ),
                  ),
                  Text(
                    'TEMPERATURE',
                    style: TextStyle(
                      fontSize: _getResponsiveFontSize(context, 30),
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.12,
                    height: screenWidth * 0.12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.thermostat, color: Colors.blue, size: 20),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.06),

              // Input Card
              Form(
                key: _formKey,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF73C2FF),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'TEMPERATURE',
                        style: TextStyle(
                          fontSize: _getResponsiveFontSize(context, 20),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Input Field and Unit
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 3,
                                  offset: const Offset(0, 7),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: _tempController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: _getResponsiveFontSize(context, 32),
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                hintText: '--',
                                hintStyle: TextStyle(
                                  fontSize: _getResponsiveFontSize(context, 32),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black38,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                isDense: true,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) return 'Required';
                                final double? temp = double.tryParse(value);
                                if (temp == null || temp < 30 || temp > 45) {
                                  return 'Invalid Temp';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          DropdownButton<String>(
                            value: _selectedUnit,
                            dropdownColor: Colors.white,
                            style: TextStyle(
                              fontSize: _getResponsiveFontSize(context, 16),
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                            items: const [
                              DropdownMenuItem(value: 'Celsius', child: Text('Celsius')),
                              DropdownMenuItem(value: 'Fahrenheit', child: Text('Fahrenheit')),
                            ],
                            onChanged: (value) {
                              setState(() => _selectedUnit = value!);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Date & Time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: _selectDate,
                            child: _pickerBox(
                              label: 'DATE',
                              value: DateFormat('dd MMM yyyy').format(_selectedDate).toUpperCase(),
                              icon: Icons.calendar_today,
                            ),
                          ),
                          GestureDetector(
                            onTap: _selectTime,
                            child: _pickerBox(
                              label: 'TIME',
                              value: _selectedTime.format(context).toUpperCase(),
                              icon: Icons.access_time,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Save button
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 3,
                              offset: const Offset(0, 7),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: _saveTemperature,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                              fontSize: _getResponsiveFontSize(context, 18),
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),

              // Records Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'RECORDS:',
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(context, 28),
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              if (_records.isEmpty)
                _emptyState(context)
              else
                ..._records.map((record) => _recordCard(context, record)).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pickerBox({required String label, required String value, required IconData icon}) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 18),
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 3,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: _getResponsiveFontSize(context, 14),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 4),
              Icon(icon, size: 16, color: Colors.black54),
            ],
          ),
        ),
      ],
    );
  }

  Widget _recordCard(BuildContext context, Map<String, dynamic> record) {
    String classification = _getClassification(record['temp'], record['unit']);
    Color color = _getClassificationColor(classification);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('EEEE, dd MMM yyyy, hh:mm a')
                  .format(record['datetime'])
                  .toUpperCase(),
              style: TextStyle(
                fontSize: _getResponsiveFontSize(context, 14),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${record['temp']}° ${record['unit']}',
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(context, 20),
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                Text(
                  classification.toUpperCase(),
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(context, 14),
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyState(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.thermostat_outlined, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No temperature records yet',
            style: TextStyle(
              fontSize: _getResponsiveFontSize(context, 18),
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first temperature reading above.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: _getResponsiveFontSize(context, 14),
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
