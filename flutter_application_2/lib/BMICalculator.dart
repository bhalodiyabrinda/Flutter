import 'package:flutter/material.dart';

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String _bmiResult = '';
  String _condition = '';

  void _calculateBMI() {
    final double height = double.parse(_heightController.text) / 100;
    final double weight = double.parse(_weightController.text);
    final double bmi = weight / (height * height);

    setState(() {
      _bmiResult = bmi.toStringAsFixed(2);
      if (bmi < 18.5) {
        _condition = 'Underweight';
      } else if (bmi >= 18.5 && bmi <= 24.9) {
        _condition = 'Normal weight';
      } else if (bmi >= 25 && bmi <= 29.9) {
        _condition = 'Overweight';
      } else if (bmi >= 30 && bmi <= 35) {
        _condition = 'Obese';
      } else {
        _condition = 'Severe obesity';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'BMI RANGE:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Table(
              border: TableBorder.all(color: Colors.black),
              children: [
                _buildTableRow('BMI VALUE', 'CONDITION', true),
                _buildTableRow('Below 18.5', 'Underweight'),
                _buildTableRow('18.5-24.9', 'Normal weight'),
                _buildTableRow('25-29.9', 'Overweight'),
                _buildTableRow('30-35', 'Obese'),
                _buildTableRow('>35', 'Severe obesity'),
              ],
            ),
            SizedBox(height: 30),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateBMI,
              child: Text('Calculate BMI'),
            ),
            SizedBox(height: 20),
            Text(
              _bmiResult.isNotEmpty
                  ? 'Your BMI: $_bmiResult ($_condition)'
                  : 'Enter your height and weight',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String value1, String value2,
      [bool isHeader = false]) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value1,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
              color: isHeader ? Colors.black : Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value2,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
              color: isHeader ? Colors.black : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
