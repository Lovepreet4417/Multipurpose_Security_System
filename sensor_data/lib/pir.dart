import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PIR extends StatefulWidget {
  const PIR({Key? key}) : super(key: key);

  @override
  State<PIR> createState() => _PIRState();
}

class _PIRState extends State<PIR> {
  Color color_of_circle = Colors.white;
  String pir = "";

  Future<void> getDataValue() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.thingspeak.com/channels/1741095/feeds.json?api_key=GYVZZC4I98DKCU6T&results=2"));
    if (response.statusCode == 200) {
      var data = response.body;
      print("data value is $data");
      var decodedData = jsonDecode(data);

      setState(() {
        pir = decodedData['feeds'][1]['field2'];

        print(pir);
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    getDataValue();
  }

  @override
  Widget build(BuildContext context) {
    String get_response() {
      if (pir == "1") {
        return "YES";
      }
      if (pir == "0") {
        return "NO";
      } else {
        return "";
      }
    }

    Color get_color() {
      if (pir == "1") {
        return Color.fromRGBO(239, 83, 80, 1);
      }
      if (pir == "0") {
        return Color.fromRGBO(102, 187, 106, 1);
      } else {
        return Color.fromRGBO(255, 255, 255, 1);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Motion Sensor Status"),
        centerTitle: true,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignmen,
        children: [
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Motion was detected?",
                style: TextStyle(fontSize: 30.0),
              ),
            ],
          ),
          SizedBox(
            height: 40.0,
          ),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(width: 0),
              shape: BoxShape.circle,
              color: get_color(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  get_response(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
