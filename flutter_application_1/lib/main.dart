import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screen/master_screen.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MasterScreen());
  }
}
