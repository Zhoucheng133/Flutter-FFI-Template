import 'dart:ffi';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef Add = Int Function(Int a, Int b);
typedef AddDart = int Function(int a, int b);


class Adder extends StatefulWidget {
  const Adder({super.key});

  @override
  State<Adder> createState() => _AdderState();
}

class _AdderState extends State<Adder> {

  TextEditingController num1=TextEditingController(text: "1");
  TextEditingController num2=TextEditingController(text: "2");

  static int dylibHandler(List params){
    final dynamicLib=DynamicLibrary.open(Platform.isMacOS ? 'libcore.dylib' : 'libcore.dll');
    final AddDart add=dynamicLib
      .lookup<NativeFunction<Add>>('Add')
      .asFunction();
    return add(params[0], params[1]);
  }

  Future<void> handler(BuildContext context) async {
    if(num1.text.isEmpty || num2.text.isEmpty){
      return;
    }
    int n1=int.parse(num1.text);
    int n2=int.parse(num2.text);
    
    int result=await compute(dylibHandler, [n1, n2]);
    if(context.mounted){
      showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          title: Text("Result"),
          content: Text("$result"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: Text("OK")
            )
          ],
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      children: [
        SizedBox(
          width: 100,
          child: TextField(
            controller: num1,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
        Padding(
          padding: .symmetric(horizontal: 5),
          child: Icon(
            Icons.add_rounded
          ),
        ),
        SizedBox(
          width: 100,
          child: TextField(
            controller: num2,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
        Padding(
          padding: .only(left: 10),
          child: FilledButton(
            onPressed: () => handler(context), 
            child: Text("Go")
          ),
        )
      ],
    );
  }
}