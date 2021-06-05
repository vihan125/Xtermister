import 'package:flutter/material.dart';


class Calender extends StatefulWidget {
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body:Container(
        color: Colors.amber,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
