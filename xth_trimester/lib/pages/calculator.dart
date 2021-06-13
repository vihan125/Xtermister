import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:xth_trimester/pages/show_aleart.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> with AutomaticKeepAliveClientMixin {


  List<String> _methods = ['LMP','CD','US','EDC'];
  String method = "LMP";
  CalendarController _controller;
  String dueD = "";
  String embAge = "";

  void initState(){
    super.initState();
    _controller = CalendarController();
  }

  String getMonth (int month){
    if (month == 1){
      return "January";
    }else if (month == 2){
      return "February";
    }else if (month == 3){
      return "March";
    } else if (month == 4){
      return "April";
    }else if (month == 5){
      return "May";
    }else if (month == 6){
      return "June";
    }else if (month == 7){
      return "July";
    }else if (month == 8){
      return "August";
    }else if (month == 9){
      return "September";
    }else if (month == 10){
      return "Octomber";
    }else if (month == 11){
      return "November";
    }else if (month == 12){
      return "December";
    }else{
      return null;
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50),
              Text("Due Date Calculator",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),),
              SizedBox(height: 20,),

              Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.white,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.width / 10,
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 1),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),


                    child: DropdownButton(
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down,
                        color: Colors.blueGrey,),
                      value: method,
                      iconSize: 10,
                      elevation:0,
                      underline: SizedBox(),
                      style: TextStyle(color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,),

                      onChanged: (newValue) {
                        setState(() {
                          dueD = "";
                          embAge= "";
                          method = newValue;
                        });
                        },
                      items: _methods.map((m){
                        return DropdownMenuItem(
                            child: Text(m,
                              textAlign: TextAlign.center,),
                            value: m
                        );
                      }).toList(),
                    ),
                ),
              ),

              TableCalendar(
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
                onDaySelected: (day,events){
                  DateTime today = DateTime.now();
                  int ageDiff = (today.difference(day).inHours/24).round();
                  DateTime dueDate;
                  String expDue;
                  String age;
                  if(ageDiff<0){
                    showError(context, "Future day is selected !");
                    expDue = "Not a valid input";
                    age = "";
                  }
                  else {
                      if (method == "LMP") {
                        dueDate = day.add(Duration(days: 280));
                        expDue = dueDate.day.toString() + " " +
                            getMonth(dueDate.month) + " " +
                            dueDate.year.toString();
                        age = (ageDiff ~/ 7).toString() + "W " +
                            (ageDiff % 7).toString() + "d";
                      }
                      else if (method == "CD") {
                        expDue = "Not Yet Implemented";
                        age = "Not Yet Implemented";
                      } else if (method == "US") {
                        expDue = "Not Yet Implemented";
                        age = "Not Yet Implemented";
                      } else if (method == "EDC") {
                        expDue = "Not Yet Implemented";
                        age = "Not Yet Implemented";
                      }
                  }
                  setState(() {
                    dueD = expDue;
                    embAge = age;
                  });

                },

              ),

              SizedBox(height: 30,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(30.0,0, 0,0),
                    child: Text("EDC",
                      style: TextStyle(
                          fontSize: 15,
                          color:Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                      ),),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20.0,0, 0,0),
                    child: Text(dueD,
                      style: TextStyle(
                          fontSize: 17,
                          color:Colors.grey,
                          fontWeight:FontWeight.bold
                      ),),
                  )
                ],
              ),

              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(30.0,0, 0,30),
                    child: Text("EGA",
                      style: TextStyle(
                          fontSize: 15,
                          color:Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                      ),),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20.0,0, 0,30),
                    child: Text(embAge,
                      style: TextStyle(
                          fontSize: 17,
                          color:Colors.grey,
                          fontWeight:FontWeight.bold
                      ),),
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
