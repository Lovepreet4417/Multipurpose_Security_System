import 'package:flutter/material.dart';
import 'fetch.dart';
import 'light.dart';
import 'pir.dart';
import 'imu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const IconData sensors = IconData(0xe576, fontFamily: 'MaterialIcons');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ESP32 Dashboard"),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Light()),
                  );
                },
                child: Card(
                  elevation: 10.0,
                  child: Container(
                    height: 150.0,
                    width: 130.0,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.lightbulb_outline_sharp),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text("Light"),
                        ]),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PIR()),
                  );
                },
                child: Card(
                  elevation: 10.0,
                  child: Container(
                    height: 150.0,
                    width: 130.0,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(sensors),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text("Movement Detection"),
                        ]),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Imu()),
                );
              },
              child: Card(
                elevation: 10.0,
                child: Container(
                  height: 150.0,
                  width: 130.0,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bar_chart_sharp),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text("Device tempering"),
                      ]),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Fetch()),
                );
              },
              child: Card(
                elevation: 10.0,
                child: Container(
                  height: 150.0,
                  width: 130.0,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.mic),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text("Sound"),
                      ]),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
      ]),
    );
  }
}
