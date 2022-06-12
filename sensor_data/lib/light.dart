import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:http/http.dart' as http;

class Light extends StatefulWidget {
  const Light({Key? key}) : super(key: key);

  @override
  State<Light> createState() => _LightState();
}

class _LightState extends State<Light> {
  // bool isSwitched = false;
  String light_value = "";
  Future<void> get_Value() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.thingspeak.com/channels/1741095/feeds.json?api_key=GYVZZC4I98DKCU6T&results=2"));
    if (response.statusCode == 200) {
      var data = response.body;
      print("data value is $data");
      var decodedData = jsonDecode(data);

      setState(() {
        light_value = decodedData['feeds'][1]['field4'];
        // light_value = "0";
        // imu_value = '4095';
        print(light_value);
      });
    } else {
      print(response.statusCode);
    }
  }

  Icon get_icon() {
    if (light_value == "0") {
      return Icon(
        Icons.lightbulb_outlined,
        size: 50.0,
      );
    } else {
      return Icon(
        Icons.lightbulb_sharp,
        size: 50.0,
      );
    }
  }

  Text get_label() {
    if (int.parse(light_value) == 0) {
      return Text(
        "Pitch Black",
        style: TextStyle(fontSize: 30.0),
      );
    } else if (int.parse(light_value) >= 1 || int.parse(light_value) <= 11) {
      return Text(
        "very Dark",
        style: TextStyle(fontSize: 30.0),
      );
    } else if (int.parse(light_value) >= 12 || int.parse(light_value) <= 51) {
      return Text(
        "Dark Indoors",
        style: TextStyle(fontSize: 30.0),
      );
    } else if (int.parse(light_value) >= 52 || int.parse(light_value) <= 201) {
      return Text(
        "Dim Indoors",
        style: TextStyle(fontSize: 30.0),
      );
    } else if (int.parse(light_value) >= 202 || int.parse(light_value) <= 401) {
      return Text(
        "Normal Indoors",
        style: TextStyle(fontSize: 30.0),
      );
    } else {
      return Text(
        "Bright Indoors",
        style: TextStyle(fontSize: 30.0),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_Value();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("LDR Sensor Status"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 250,
              child: Card(
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        get_icon(),
                        SizedBox(
                          height: 30.0,
                        ),
                        get_label(),
                      ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
