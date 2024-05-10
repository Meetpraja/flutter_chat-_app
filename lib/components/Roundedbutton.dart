import 'package:flutter/material.dart';
class RoundButton extends StatelessWidget{
  const RoundButton({super.key,required this.ontap,required this.text});
  final VoidCallback ontap;

  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.blueAccent
        ),
        child: Center(
          child: Text(text ,
            style: const TextStyle(
            color: Colors.white
          ),), ),
      ),
    );
  }
}