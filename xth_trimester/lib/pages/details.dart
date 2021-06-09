import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xth_trimester/dataBase/db_helper.dart';
//import 'patient.dart';
import 'package:xth_trimester/dataBase/patient_model.dart';


class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  Map data = {};
  bool isEnabled =  false;
  InputDecoration decoration = InputDecoration(border: InputBorder.none);
  List<String> _methods = ['LMP','CD','US','EDC','Born'];
  DateTime _chosenDateTime;
  Mother p;

  String getDate (DateTime d){

    if((d.month<10) && (d.day<10)){
      return d.year.toString()+"-0"+d.month.toString()+"-0"+d.day.toString();
    }
    else if ((d.month<10) && (d.day>=10)){
      return d.year.toString()+"-0"+d.month.toString()+"-"+d.day.toString();
    }
    else if ((d.month>=10) && (d.day<10)){
      return d.year.toString()+"-"+d.month.toString()+"-0"+d.day.toString();
    }else {
      return d.year.toString() + "-" + d.month.toString() + "-" + d.day.toString();
    }

  }

  void _showDatePicker(ctx,Mother p) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    _chosenDateTime = DateTime.parse(p.calDate);
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
          height: 500,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Container(
                height: 400,
                child: CupertinoDatePicker(
                    initialDateTime: DateTime.parse(p.calDate) ,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (val){
                      setState(() {
                        _chosenDateTime = val;
                      });
                    }),
              ),

              // Close the modal
              CupertinoButton(
                child: Text('OK'),
                onPressed: () async {
                  DateTime today = DateTime.now();
                  DateTime pickedDate = _chosenDateTime;
                  int difference = (today.difference(pickedDate).inHours/24).round();
                  DateTime dueDate = pickedDate.add(Duration(days:280));
                  int id = p.id;
                  String date = getDate(_chosenDateTime);
                  String due = getDate(dueDate);

                  Database db = await DBHelper.instance.db;
                  await db.execute('UPDATE mothers SET calDate = "$date",embryoAge = "$difference",dueDate="$due" WHERE id = $id');

                  var mom = await db.rawQuery('select * from mothers where id = $id');
                  Mother m = Mother.fromMap(mom[0]);
                  Navigator.of(ctx).pop();
                  Navigator.pushReplacementNamed(context, "/details",
                      arguments: {'Patient': m});
                },
              )
            ],
          ),
        ));
  }
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    p = data['Patient'];
    return Scaffold(
      appBar: AppBar(
//        leading: Builder(
//          builder: (BuildContext context){
//            return IconButton(
//              icon: Icon(Icons.arrow_back),
//              onPressed: (){
//                Navigator.pushReplacementNamed(context, '/');
//              },
//              color: Colors.white,
//            );
//          }
//        ),
        title: Text("Patient Details"),
        centerTitle: true,
        backgroundColor: Colors.cyan[300],
      ),
      body: Container(
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
              SizedBox(height: 30.0,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(width: 20.0,),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(p.icon),
                        radius: 50.0,
                      ),
                    ),
                  SizedBox(width: 20.0,),
                 Expanded(
                   child:Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Text("Name",
                           style: TextStyle(
                             color: Colors.grey[800],
                             fontSize: 15,
                           ),),

                         SizedBox(height: 8,),

                         SizedBox(
                           height: 25,
                           child: TextField(
                              style: TextStyle(
                                fontSize:20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                               controller: TextEditingController(text:p.firstName),
                               enabled: isEnabled,
                                decoration: decoration,
                             ),
                         ),

                         SizedBox(height: 10,),
                         Text("Last name",
                           style: TextStyle(
                             color: Colors.grey[800],
                             fontSize: 15,
                           ),),
                         SizedBox(height: 8,),
                         SizedBox(
                           height: 25,
                           child: TextField(
                             style: TextStyle(
                               fontSize:20,
                               color: Colors.black,
                               fontWeight: FontWeight.bold,
                             ),
                             controller: TextEditingController(text:p.lastName),
                             enabled: isEnabled,
                             decoration: decoration,
                           ),
                         ),

                       ],
                     ),
                 ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Primary phone",
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 15,
                            ),),
                          SizedBox(height: 8,),
                          SizedBox(
                            height: 25,
                            width: 130,
                            child: TextField(
                              style: TextStyle(
                                fontSize:20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              controller: TextEditingController(text:p.pNumber),
                              enabled: isEnabled,
                              decoration: decoration,
                            ),
                          ),
                        ],
                      ),
                    ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Secondary phone",
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 15,
                            ),),
                          SizedBox(height: 8,),
                          SizedBox(
                            height: 25,
                            width: 130,
                            child: TextField(
                              style: TextStyle(
                                fontSize:20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              controller: TextEditingController(text:p.sNumber),
                              enabled: isEnabled,
                              decoration: decoration,
                            ),
                          ),
                        ],
                      ),
                  ),

                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: RaisedButton(
                      color: Colors.cyan,
                      textColor: Colors.white,
                      onPressed: (){},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text("BORN",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: RaisedButton.icon(
                      onPressed: (){
                        String url = p.pNumber;
                        launch("tel:$url");
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      icon: Icon(
                        Icons.call
                      ),
                      label: Text("Call"),
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
              Divider(height: 40,
              thickness: 2.0,
              color: Colors.grey[600],),
               Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Table(
                    columnWidths: {
                      0: FlexColumnWidth(0.5),
                    },
                    children:[
                      TableRow(
                        children: [
                          Center(child: Padding(
                            padding: EdgeInsets.fromLTRB(0,15,0,0),
                            child: Text("Method",
                              style: TextStyle(fontSize: 15.0,
                              color: Colors.grey[800]),),
                          )),
                          Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: Colors.cyan[300],
                            ),
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 70, 0),
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.cyan[200],
                                borderRadius: BorderRadius.circular(10)
                              ),

                              child: DropdownButton(
                                isExpanded: true,
                                  icon: Icon(Icons.keyboard_arrow_down,
                                  color: Colors.white,),
                                  value: p.calMethod,
                                  iconSize: 20,
                                  elevation: 40,
                                  underline: SizedBox(),
                                  style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,),

                                  onChanged: (newValue) async {
                                  int id = p.id;
                                    Database db = await DBHelper.instance.db;
                                    await db.execute('UPDATE mothers SET calMethod = "$newValue" WHERE id = $id');
                                    setState(() {
                                      p.calMethod= newValue;
                                    });
                                  },
                                  items: _methods.map((method){
                                    return DropdownMenuItem(
                                      child: Text(method,
                                      textAlign: TextAlign.center,),
                                      value: method
                                    );
                                  }).toList(),
                                ),
                            ),
                          ),
                        ],
                      ),

                      TableRow(
                        children: [
                          Center(child: Padding(
                            padding: EdgeInsets.fromLTRB(0,25,0,0),
                            child: Text("Date",
                              style: TextStyle(fontSize: 15.0,
                              color: Colors.grey[800]),),
                          )),

                          Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(p.calDate,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                    ),),
                                    Container(
                                      child: IconButton(
                                        icon: Icon(Icons.mode_edit,
                                        size: 25,),
                                        color: Colors.blueGrey,
                                        onPressed: (){
                                          _showDatePicker(context,p);
                                        },
                                      ),
                                    ),
                                  ],
                               )
                            ),
                        ],
                      ),

                      TableRow(
                        children: [
                          Center(child: Padding(
                            padding: EdgeInsets.fromLTRB(0,10,0,0),
                            child: Text("Embryo Age",
                              style: TextStyle(fontSize: 15.0,
                                  color: Colors.grey[800]),),
                          )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(10,10,0,0),
                              child: Text(p.ageWeeks,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                        ],
                      ),


                      TableRow(
                        children: [
                          Center(child: Padding(
                            padding: EdgeInsets.fromLTRB(0,10,0,0),
                            child: Text("Estimated Due Date",
                              style: TextStyle(fontSize: 15.0,
                                  color: Colors.grey[800]),),
                          )),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10,10,0,0),
                            child: Text(p.dueDate,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),),
                          ),
                        ],
                      )

                    ],
                  ),
                ),
              SizedBox(height: 30,),
            ],
          ),
        ),
      ),

      backgroundColor: Colors.white,
    );
  }
}
