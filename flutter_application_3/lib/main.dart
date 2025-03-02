import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

main() => runApp(myApp());

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //mainAxisAlignment: MainAxisAlingnment.start
            //crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              Expanded(
                child: Container(
                  color: Color.fromARGB(255, 52, 223, 250),
                ),
              ),
              Expanded(
                child: Container(
                  color: Color.fromARGB(255, 227, 78, 241),
                ),
              ),
              Expanded(
                child: Container(
                  color: Color.fromARGB(255, 58, 240, 91),
                ),
              ),
              // Container(
              //   width: 60,
              //   height: 100,
              //   color: Color.fromARGB(255, 52, 223, 250),
              // ),
              // Container(
              //   width: 60,
              //   height: 100,
              //   color: Color.fromARGB(255, 227, 78, 241),
              // ),
              // Container(
              //   width: 60,
              //   height: 100,
              //   color: Color.fromARGB(255, 58, 240, 91),
              // ),
            ],
          ),
        ),
      )),
    );
  }
}
