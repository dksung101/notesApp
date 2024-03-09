import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:flutter/services.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> with TickerProviderStateMixin {
  int _timeLeftWork = 1500;
  int _timeLeftBreak = 300;
  bool _isWorkTime = true;
  late final AnimationController _Acontroller;
  late final AnimationController _Bcontroller;
  late final AnimationController _Ccontroller;
  late final AnimationController _Dcontroller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _Acontroller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _Bcontroller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _Ccontroller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _Dcontroller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
  }

  void dispose() {
    _Acontroller.dispose();
    _Bcontroller.dispose();
    _Ccontroller.dispose();
    _Dcontroller.dispose();
    super.dispose();
  }

  bool Acompleted = false;
  bool Bcompleted = false;
  bool Ccompleted = false;
  bool Dcompleted = false;

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
    debugPaintSizeEnabled = true;
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
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background),
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
                            HapticFeedback.heavyImpact();
                            _controller.pause();
                          },
                          child: Text("S T O P",
                              style: TextStyle(
                                  fontFamily: 'Geomanist',
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.tertiary)),
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
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 3),
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {
                              HapticFeedback.heavyImpact();
                              _controller.start();
                            },
                            child: Text("S T A R T",
                                style: TextStyle(
                                    fontFamily: 'Geomanist',
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiary))),
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
                            HapticFeedback.heavyImpact();
                            _controller.restart();
                            _controller.pause();
                          },
                          child: Text("R E S E T",
                              style: TextStyle(
                                  fontFamily: 'Geomanist',
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.tertiary)),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (Acompleted == false) {
                      Acompleted = true;
                      _Acontroller.forward();
                      HapticFeedback.heavyImpact();
                    } else {
                      Acompleted = false;
                      _Acontroller.reverse();
                      HapticFeedback.heavyImpact();
                    }
                  });
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.24,
                  child: Lottie.asset('assets/wholething.json',
                      controller: _Acontroller),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (Bcompleted == false) {
                      Bcompleted = true;
                      _Bcontroller.forward();
                      HapticFeedback.heavyImpact();
                    } else {
                      Bcompleted = false;
                      _Bcontroller.reverse();
                      HapticFeedback.heavyImpact();
                    }
                  });
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.24,
                  child: Lottie.asset('assets/wholething.json',
                      controller: _Bcontroller),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (Ccompleted == false) {
                      Ccompleted = true;
                      _Ccontroller.forward();
                      HapticFeedback.heavyImpact();
                    } else {
                      Ccompleted = false;
                      _Ccontroller.reverse();
                      HapticFeedback.heavyImpact();
                    }
                  });
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.24,
                  child: Lottie.asset('assets/wholething.json',
                      controller: _Ccontroller),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (Dcompleted == false) {
                      Dcompleted = true;
                      _Dcontroller.forward();
                      HapticFeedback.heavyImpact();
                    } else {
                      Dcompleted = false;
                      _Dcontroller.reverse();
                      HapticFeedback.heavyImpact();
                    }
                  });
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.24,
                  child: Lottie.asset('assets/wholething.json',
                      controller: _Dcontroller),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
