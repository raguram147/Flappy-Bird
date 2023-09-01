import 'package:flutter/material.dart';

class MyBrid extends StatelessWidget {
  const MyBrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      child: Image.asset('assets/img/flappy.png'),
    );
  }
}
