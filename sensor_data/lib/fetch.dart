import 'package:flutter/material.dart';

class Fetch extends StatelessWidget {
  const Fetch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 180,
        width: 180,
        child: Center(
          child: Text("Fetching data..."),
        ),
      ),
    );
  }
}
