import 'package:flutter/material.dart';

class BMIC extends StatefulWidget {
  const BMIC({super.key});

  @override
  State<BMIC> createState() => _BMICState();
}

class _BMICState extends State<BMIC> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double result = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 120, 67, 211),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('asset/th.jpeg'))),
          ),
          TextField(
            controller: _heightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Enter your height in CM.",
              icon: Icon(Icons.trending_up),
            ),
          ),
          TextField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Enter your weight in KG.",
              icon: Icon(Icons.monitor_weight),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: calculateBMI,
            child: const Text('Calculate BMI'),
            style: ElevatedButton.styleFrom(
                // primary: Colors.deepPurple,
                ),
          ),
          const SizedBox(height: 20),
          Text(
            result == 0
                ? "Enter Values"
                : "Your BMI is ${result.toStringAsFixed(2)}",
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void calculateBMI() {
    setState(() {
      try {
        double height =
            double.parse(_heightController.text) / 100; // Convert cm to meters
        double weight = double.parse(_weightController.text);
        double bmi = weight / (height * height);
        result = bmi;
      } catch (e) {
        result = 0;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter valid numbers'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }
}

void main() {
  runApp(MaterialApp(
    home: BMIC(),
  ));
}
