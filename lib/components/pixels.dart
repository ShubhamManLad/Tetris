import 'package:flutter/material.dart';

class BlankPixel extends StatelessWidget {
  final int i;
  const BlankPixel({super.key, required this.i});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        color: Colors.white12,
      ),
    );
  }
}

class ActivePixel extends StatelessWidget {
  final int i;
  const ActivePixel({super.key, required this.i});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        decoration: BoxDecoration(
            color: getColor(i),
            borderRadius: BorderRadius.all(Radius.circular(4))
        ),
      ),
    );
  }
}

class Inactive extends StatelessWidget {
  const Inactive({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        color: Colors.red,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16))
        ),
      ),
    );
  }
}

Color getColor(int i){
  switch(i){
    case 0:
      return Colors.green;
    case 1:
      return Colors.blue;
    case 2:
      return Colors.lightBlueAccent;
    case 3:
      return Colors.yellow;
    case 4:
      return Colors.orange;
    case 5:
      return Colors.pink;
    case 6:
      return Colors.greenAccent;
    case 7:
      return Colors.yellowAccent;
    default:
      return Colors.purple;
  }
}

