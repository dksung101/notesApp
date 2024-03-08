import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int _timeLeftWork = 1500;
  int _timeLeftBreak = 300;
  bool _isWorkTime = true;

  CountdownController _controller = new CountdownController(autoStart: false);

  // CountdownController _controllerBreak =
  //     new CountdownController(autoStart: true);

  String remainingTime(int currTime) {
    int minutes = (currTime / 60).floor();
    int seconds = currTime - (minutes * 60);
    if (seconds < 10) {
      return "$minutes : 0$seconds";
    }
    return "$minutes : $seconds";
  }

  bool isWorkTime() {
    return _isWorkTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
            "Pomodoro Timer",
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontFamily: 'Geomanist',
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.background),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width,
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.background),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(isWorkTime() ? "Work Time" : "Break Time",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Geomanist',
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary)),
              Countdown(
                controller: _controller,
                seconds: isWorkTime() ? _timeLeftWork : _timeLeftBreak,
                onFinished: () {
                  setState(() {
                    _isWorkTime = !_isWorkTime;
                    _controller.restart();
                    _controller.pause();
                  });
                },
                build: (context, double time) => Text(
                  remainingTime(time.toInt()),
                  style: TextStyle(
                    fontSize: 100,
                    fontFamily: 'Geomanist',
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: MaterialButton(
                      color: Colors.red.shade100,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 3),
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        _controller.pause();
                      },
                      child: Text("S T O P",
                          style: TextStyle(
                              fontFamily: 'Geomanist',
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.tertiary)),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: MaterialButton(
                        color: Colors.green.shade100,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 3),
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          _controller.start();
                        },
                        child: Text("S T A R T",
                            style: TextStyle(
                                fontFamily: 'Geomanist',
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.tertiary))),
                  ),
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: MaterialButton(
                      color: Colors.grey.shade100,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 3),
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        _controller.restart();
                      },
                      child: Text("R E S E T",
                          style: TextStyle(
                              fontFamily: 'Geomanist',
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.tertiary)),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
