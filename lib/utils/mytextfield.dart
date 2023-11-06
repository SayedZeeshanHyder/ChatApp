import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget{

  final labeltext;
  final hinttext;
  final bool obsure;
  final keyboardtype;
  final controller;
  const MyTextField({required this.keyboardtype,required this.controller,required this.labeltext,this.hinttext,this.obsure=false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.titleMedium,
      controller: controller,
      obscureText: obsure,
      decoration: InputDecoration(
        hintText: hinttext,
        labelText: labeltext,
      ),
    );
  }

}