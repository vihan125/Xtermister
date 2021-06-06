import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:xth_trimester/dataBase/db_helper.dart';
import 'package:xth_trimester/dataBase/patient_model.dart';
import 'package:sqflite/sqflite.dart';


class Calender extends StatefulWidget {
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> with AutomaticKeepAliveClientMixin {

  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events={};
  Map<DateTime, List<dynamic>> _getevents={};
  List<dynamic> _selectedEvents;
  int length = -1;
  List <Mother> Mothers=[];

  void initState(){
    super.initState();
    _controller = CalendarController();
    getData();
  }

  void getData()async {
    //display = loading();
    Database db = await DBHelper.instance.db;
    var mothers = await db.rawQuery('select * from mothers');
    //print(mothers);
    length = mothers.length;
    if (length>=0){
      for (int i =0; i< length; i++){
        Mother m = Mother.fromMap(mothers[i]);
        DateTime d = DateTime.parse(m.calDate);
        if (_getevents[d] != null){
          _getevents[d].add(m);
        }else{
          _getevents[d] = [m];
        }
      }
      setState(() {
       _events = _getevents;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
            body:TableCalendar(
              events: _events,
              initialCalendarFormat: CalendarFormat.month,
              calendarStyle: CalendarStyle(
                  canEventMarkersOverflow: true,
                  todayColor: Colors.amber,
                  selectedColor: Theme.of(context).primaryColor,
                  todayStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white)),
              headerStyle: HeaderStyle(
                  centerHeaderTitle: true,
                  formatButtonDecoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20.0),
                  ),
                  formatButtonTextStyle: TextStyle(color: Colors.white),
                  formatButtonShowsNext: false,
              ),
              builders: CalendarBuilders(
                    selectedDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                      color: Colors.cyan[500],
                      borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                      )),
                    todayDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                      )),
                    ),
              calendarController: _controller,
            )
    );
  }

  @override
  bool get wantKeepAlive => true;
}
