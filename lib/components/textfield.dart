import 'package:flutter/material.dart';

class TextFields extends StatelessWidget{
  const TextFields({super.key,
    required this.controllers,
    required this.text,
    required this.icon,
    required this.errortext,
    required this.obstxt,
  });

  final String text;
  final Icon icon;
  final controllers ;
  final String errortext;
  final bool obstxt;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obstxt,
      controller: controllers,
      style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
      decoration: InputDecoration(
          fillColor: Theme.of(context).colorScheme.inversePrimary,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          focusedBorder:OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color:Theme.of(context).colorScheme.inversePrimary),
          ),
          label: Text(text,
            style:TextStyle(color:Theme.of(context).colorScheme.inversePrimary),
          ),
          suffixIcon: icon),
      validator: (value) {
        if (value!.isEmpty) {
          return errortext;
        }
        return null;
      },
    );
  }
}