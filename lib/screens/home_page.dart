import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //create the Buisness Logic of the app
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  String digitSeceonds = "00";
  String digitMinutes = "00";
  String digitHours = "00";
  Timer? timer;
  bool started = false;
  List laps = [];

  //Creating the stop timer function
  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  //Creating the reset function
  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitSeceonds = "00";
      digitMinutes = "00";
      digitHours = "00";

      started = false;
    });
  }

  //List
  void addLabs() {
    String lap = "$digitHours:$digitMinutes:$digitSeceonds";
    setState(() {
      laps.add(lap);
    });
  }

  //creating the start timer function
  void start() {
    started = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }

      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitSeceonds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Center(
                child: Text(
                  "StopWatch App",
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                shadowColor: Colors.red,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(2, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              children: [
                                Textt(
                                  text: digitHours,
                                  color: (!started == true)
                                      ? Colors.red
                                      : Colors.green,
                                  fontsize: 85,
                                ),
                                const Textt(
                                    text: ":", color: Colors.red, fontsize: 85),
                                Textt(
                                    text: digitMinutes,
                                    color:
                                        (!started) ? Colors.red : Colors.green,
                                    fontsize: 85),
                                const Textt(
                                    text: ":", color: Colors.red, fontsize: 85),
                                Textt(
                                    text: digitSeceonds,
                                    color:
                                        (!started) ? Colors.red : Colors.green,
                                    fontsize: 85),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: laps.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Card(
                          margin: const EdgeInsets.all(10),
                          child: Text(
                            "${laps[index]}",
                            style:
                                Theme.of(context).textTheme.headline1!.copyWith(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepOrangeAccent,
                                    ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        (!started) ? start() : stop();
                      },
                      fillColor: Colors.green,
                      shape: const StadiumBorder(
                        side: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: Textt(
                          text: (!started) ? "Start" : "Stop",
                          color: Colors.black,
                          fontsize: 20),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      addLabs();
                    },
                    icon: const Icon(
                      Icons.flag_circle_sharp,
                      size: 50,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        reset();
                      },
                      fillColor: Colors.green,
                      shape: const StadiumBorder(
                        side: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: const Textt(
                        text: "Reset",
                        color: Colors.red,
                        fontsize: 20,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Textt extends StatelessWidget {
  final String text;
  final Color color;
  final double fontsize;
  const Textt({
    Key? key,
    required this.text,
    required this.color,
    required this.fontsize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline1!.copyWith(
            fontSize: fontsize,
            fontWeight: FontWeight.bold,
            color: color,
          ),
    );
  }
}
