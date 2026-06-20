import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef Concat = Pointer<Utf8> Function(Pointer<Utf8> a, Pointer<Utf8> b);

class Concater extends StatefulWidget {
  const Concater({super.key});

  @override
  State<Concater> createState() => _ConcaterState();
}

class _ConcaterState extends State<Concater> {
  TextEditingController str1=TextEditingController(text: "Hello");
  TextEditingController str2=TextEditingController(text: " World");

  static String dylibHandler(List params){
    final dynamicLib=DynamicLibrary.open(Platform.isMacOS ? 'libcore.dylib' : 'libcore.dll');
    final Concat concat=dynamicLib
      .lookup<NativeFunction<Concat>>('Concat')
      .asFunction();
    final a = (params[0] as String).toNativeUtf8();
    final b = (params[1] as String).toNativeUtf8();
    final resultPtr = concat(a, b);
    final result = resultPtr.toDartString();

    malloc.free(a);
    malloc.free(b);

    return result;
  }

  Future<void> handler(BuildContext context) async {
    if(str1.text.isEmpty || str2.text.isEmpty){
      return;
    }
    
    String result=await compute(dylibHandler, [str1.text, str2.text]);
    if(context.mounted){
      showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          title: Text("Result"),
          content: Text(result),
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
            controller: str1,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
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
            controller: str2,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
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