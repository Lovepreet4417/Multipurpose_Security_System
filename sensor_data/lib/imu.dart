import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Imu extends StatefulWidget {
  const Imu({Key? key}) : super(key: key);

  @override
  State<Imu> createState() => _ImuState();
}

class _ImuState extends State<Imu> {
  String imu_value = "";
  Future<void> get_Value() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.thingspeak.com/channels/1741095/feeds.json?api_key=GYVZZC4I98DKCU6T&results=2"));
    if (response.statusCode == 200) {
      var data = response.body;
      print("data value is $data");
      var decodedData = jsonDecode(data);

      setState(() {
        imu_value = decodedData['feeds'][1]['field3'];
        // imu_value = '4095';
        print(imu_value);
      });
    } else {
      print(response.statusCode);
    }
  }

  String get_text() {
    if (imu_value == '1000') {
      return 'Normal';
    } else {
      return 'vibrations found';
    }
  }

  Color get_color() {
    if (imu_value == '1000') {
      return Color.fromRGBO(102, 187, 106, 1);
    } else {
      return Color.fromRGBO(239, 83, 80, 1);
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            ListTile(
              leading: Text('Device Status'),
              trailing: Text(get_text()),
            ),
            ListTile(
              leading: Text('Current Vibration value '),
              trailing: Text("$imu_value"),
            ),
            ListTile(
              leading: Text('Signal'),
              trailing: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: get_color(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
