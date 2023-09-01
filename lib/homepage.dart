import 'dart:async';

import 'package:ads/barriers.dart';
import 'package:ads/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdy = 0;
  double time = 0;
  double height = 0;
  double initheight = birdy;
  bool gameStarted = false;
  static double barrierx_1 = 1;
  double barrierx_2 = barrierx_1 + 1.5;

  void jump() {
    setState(() {
      time = 0;
      initheight = birdy;
    });
  }

  void startGame() {
    gameStarted = true;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2 * time;
      setState(() {
        birdy = initheight - height;

        // barrierx_1 -= 0.05;
        // barrierx_2 -= 0.05;
      });
      setState(() {
        if (barrierx_1 < -2) {
          barrierx_1 += 3.5;
        } else {
          barrierx_1 -= 0.05;
        }
      });
      setState(() {
        if (barrierx_2 < -2) {
          barrierx_2 += 3.5;
        } else {
          barrierx_2 -= 0.05;
        }
      });
      if (birdIsDead()) {
        timer.cancel();
        gameStarted = false;
        // _showDialog();
      }
    });
  }

  bool birdIsDead() {
    if (birdy < -1 || birdy > 1) {
      return true;
    }
    return false;
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const AlertDialog(
            backgroundColor: Colors.brown,
            title: Center(
              child: Text(
                "G A M E O V E R",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: Colors.white,
                    child: Text(
                      "PLAY AGAIN",
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdy = 0;
      gameStarted = false;
      time = 0;
      initheight = birdy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(children: [
          Expanded(
              flex: 2,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdy),
                    duration: const Duration(microseconds: 0),
                    color: Colors.blue,
                    child: const MyBrid(),
                  ),
                  Container(
                    alignment: const Alignment(0, -0.3),
                    child: gameStarted
                        ? const Text("")
                        : const Text(
                            "T A P T O P L A Y",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierx_1, 1.1),
                    duration: Duration(milliseconds: 0),
                    child: const MyBarrier(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierx_1, -1.1),
                    duration: Duration(milliseconds: 0),
                    child: const MyBarrier(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierx_2, 1.1),
                    duration: Duration(milliseconds: 0),
                    child: const MyBarrier(
                      size: 150.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierx_2, -1.1),
                    duration: Duration(milliseconds: 0),
                    child: const MyBarrier(
                      size: 250.0,
                    ),
                  )
                ],
              )),
          Container(
            height: 15,
            color: Colors.green,
          ),
          Expanded(
              child: Container(
            color: Colors.brown,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Your Score",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "0",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Best Score",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "10",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  ],
                ),
              ],
            ),
          ))
        ]),
      ),
    );
  }
}
