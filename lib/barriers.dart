import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final size;
  const MyBarrier({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green,
        border:
            Border.all(width: 10, color: const Color.fromARGB(255, 3, 97, 7)),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
