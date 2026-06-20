import 'package:flutter/material.dart';
import 'package:flutter_ffi_template/components/adder.dart';
import 'package:flutter_ffi_template/components/concater.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: .min,
            children: [
              Adder(),
              SizedBox(height: 10,),
              Concater(),
            ],
          )
        ),
      ),
    );
  }
}
