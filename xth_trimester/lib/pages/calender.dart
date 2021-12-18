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
  Map<DateTime, List<dynamic>> _holidays={};
  Map<DateTime, List<dynamic>> _dueDays={};

  List<dynamic> _selectedEvents = [];
  int length = -1;

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
        DateTime d = DateTime.parse(m.dueDate);
        DateTime r1 = d.add(Duration(days: 3));
        DateTime r2 = d.add(Duration(days: 2));
        DateTime r3 = d.add(Duration(days: 1));
        DateTime r4 = d.subtract(Duration(days: 1));
        DateTime r5 = d.subtract(Duration(days: 2));
        DateTime r6 = d.subtract(Duration(days: 3));
        if (_getevents[d] != null){
          _getevents[d].add(m);
        }else{
          _getevents[d] = [m];
        }

        if (_holidays[r1] != null){
          _holidays[r1].add(m.firstName + "" + m.lastName);
        }else{
          _holidays[r1] = [m.firstName + "" + m.lastName];
        }

        if (_holidays[r2] != null){
          _holidays[r2].add(m.firstName + "" + m.lastName);
        }else{
          _holidays[r2] = [m.firstName + "" + m.lastName];
        }

        if (_holidays[r3] != null){
          _holidays[r3].add(m.firstName + "" + m.lastName);
        }else{
          _holidays[r3] = [m.firstName + "" + m.lastName];
        }

        if (_holidays[r4] != null){
          _holidays[r4].add(m.firstName + "" + m.lastName);
        }else{
          _holidays[r4] = [m.firstName + "" + m.lastName];
        }

        if (_holidays[r5] != null){
          _holidays[r5].add(m.firstName + "" + m.lastName);
        }else{
          _holidays[r5] = [m.firstName + "" + m.lastName];
        }

        if (_holidays[r6] != null){
          _holidays[r6].add(m.firstName + "" + m.lastName);
        }else{
          _holidays[r6] = [m.firstName + "" + m.lastName];
        }
      }
      setState(() {
       _events = _getevents;
       _dueDays = _holidays;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
            body:Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.cyan[100],Colors.white],
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[

                    SizedBox(height: 50),
                    Text("Due Date Calendar",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),),

                    SizedBox(height: 25,),

                    TableCalendar(
                      events: _events,
                      holidays: _dueDays,
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
                            markersBuilder: (context,date,events,holidays){
                              final children = <Widget>[];
                              if(events.isNotEmpty){
                                children.add(Stack(
                                  children: <Widget>[
                                    Container(
                                        margin: const EdgeInsets.all(4.0),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius: BorderRadius.circular(10.0)),
                                        child: Text(
                                          date.day.toString(),
                                          style: TextStyle(color: Colors.white),
                                        )
                                    ),
                                    Positioned(
                                      bottom: 1,
                                      right: 1,
                                      child: Container(
                                          color: Colors.orange[400],
                                          padding: EdgeInsets.symmetric(vertical: 1.5, horizontal: 4),
                                          child: Text("${events.length}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),)),
                                    )
                                  ],
                                )

                                );
                              }
                              return children;
                            },
                        holidayDayBuilder: (context,date,holidays)=> Container(
                            margin: const EdgeInsets.all(4.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.redAccent[100],
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Text(
                              date.day.toString(),
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      calendarController: _controller,
                      onDaySelected: (day,events,_){
                        setState(() {
                          _selectedEvents = events;
                        });
                      },

                    ),

                  SizedBox(height: 20,),

                   ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _selectedEvents.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 1.0, horizontal: 4.0),
                            child: Card(
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(context, "/details",
                                      arguments: {'Patient': _selectedEvents[index], 'changed':false, "message":""});
                                },
                                title: Text(
                                    _selectedEvents[index].firstName + " " +
                                        _selectedEvents[index].lastName),
                                subtitle: Text(_selectedEvents[index].ageWeeks),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(8.0)),
                                  child: Image.asset(_selectedEvents[index].icon),
                                ),
                              ),
                            ),
                        );
                        }
                      ),

                    SizedBox(height: 30,),
                  ],
                ),
              ),
            )
    );
  }

  @override
  bool get wantKeepAlive => true;
}
