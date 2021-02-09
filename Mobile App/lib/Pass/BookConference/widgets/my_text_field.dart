import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxLines;
  final int minLines;
  final Icon icon;
  MyTextField({this.label,this.controller , this.maxLines = 1, this.minLines = 1, this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.black87),
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        suffixIcon: icon == null ? null: icon,
          labelText: label,
          labelStyle: TextStyle(color: Colors.black45),
          
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          border:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
    );
  }
}
