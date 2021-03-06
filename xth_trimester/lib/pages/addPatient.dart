import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xth_trimester/dataBase/db_helper.dart';



class AddPatient extends StatefulWidget {

  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {

  String firstName;

  String lastName;

  String pNumber;

  String sNumber;

  String date =  DateTime.now().year.toString()+"-"+DateTime.now().month.toString()+"-"+DateTime.now().day.toString();

  String method="LMP";

  int difference;

  String dueDate = "";

  List<String> _methods = ['LMP','CD','US','EDC','Born'];


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

  void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
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
                    initialDateTime: DateTime.now(),
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (val) {
                      String d = getDate(val);
                      int dif = ((DateTime.now()).difference(val).inHours/24).round();
                      DateTime exp = val.add(Duration(days:280));
                      String due = getDate(exp);

                      setState(() {
                        dueDate = due;
                        date = d;
                        difference = dif;
                      });
                    }),
              ),

              // Close the modal
              CupertinoButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(ctx).pop(),
              )
            ],
          ),
        ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
            builder: (BuildContext context){
              return IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: (){
                  Navigator.pushReplacementNamed(context, '/');
                },
                color: Colors.white,
              );
            }
        ),
        elevation: 0,
        title: Text("New Patient"),
        centerTitle: true,
        backgroundColor: Colors.cyan[200],
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
            //mainAxisAlignment: MainAxisAlignment.end,
            //crossAxisAlignment: CrossAxisAlignment.baseline,
            children: <Widget>[
            SizedBox(height: 50.0,),

               Container(
                  height: 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Padding(
                        padding : EdgeInsets.fromLTRB(20.0, 6.0, 5.0, 5.0),
                        child: Text("First Name :",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5.0, 0.0, 20.0, 5.0),
                          child: SizedBox(
                            height: 40,
                            //width: 100,
                            child: TextField(
                              onChanged: (String fn){
                                firstName = fn;
                              },
                              style: TextStyle(
                                fontSize:20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              enabled: true,
                              decoration: InputDecoration(
                                  hintText: "First Name",
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 12.0,
                                  ),
                                  fillColor: Colors.grey[100],
                                  filled: true,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0))),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              SizedBox(height: 20.0,),

              Container(
                  height: 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Padding(
                        padding : EdgeInsets.fromLTRB(20.0, 6.0, 5.0, 5.0),
                        child: Text("Last Name :",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5.0, 0.0, 20.0, 5.0),
                          child: SizedBox(
                            height: 40,
                            //width: 100,
                            child: TextField(
                              onChanged: (String ln){
                                lastName = ln;
                              },
                              style: TextStyle(
                                fontSize:20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              enabled: true,
                              decoration: InputDecoration(
                                  hintText: "Last Name",
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 12.0,
                                  ),
                                  fillColor: Colors.grey[100],
                                  filled: true,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0))),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              SizedBox(height: 20.0,),

              Container(
                height: 40.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Padding(
                      padding : EdgeInsets.fromLTRB(20.0, 6.0, 5.0, 5.0),
                      child: Text("Primary Contact No :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5.0, 0.0, 20.0, 5.0),
                        child: SizedBox(
                          height: 40,
                          //width: 100,
                          child: TextField(
                            onChanged: (String pn){
                              pNumber = pn;
                            },
                            style: TextStyle(
                              fontSize:20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            enabled: true,
                            decoration: InputDecoration(
                                hintText: "Contact no",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12.0,
                                ),
                                fillColor: Colors.grey[100],
                                filled: true,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0))),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.0,),

              Container(
                height: 40.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Padding(
                      padding : EdgeInsets.fromLTRB(20.0, 6.0, 5.0, 5.0),
                      child: Text("Secondary Contact No :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5.0, 0.0, 20.0, 5.0),
                        child: SizedBox(
                          height: 40,
                          //width: 100,
                          child: TextField(
                            onChanged: (String sn){
                              sNumber = sn;
                            },
                            style: TextStyle(
                              fontSize:20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            enabled: true,
                            decoration: InputDecoration(
                                hintText: "Contact no",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 15.0,
                                ),
                                fillColor: Colors.grey[100],
                                filled: true,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0))),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.0,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Padding(
                    padding : EdgeInsets.fromLTRB(20.0, 15.0, 5.0, 5.0),
                    child: Text("Method of Calculation :",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),),
                  ),

                  Container(
                    width: 160,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Colors.cyan[300],
                      ),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                        decoration: BoxDecoration(
                            color: Colors.cyan[200],
                            borderRadius: BorderRadius.circular(10)
                        ),

                        child: DropdownButton(
                          isExpanded: true,
                          icon: Icon(Icons.keyboard_arrow_down,
                            color: Colors.white,),
                          value: "LMP",
                          iconSize: 20,
                          elevation: 40,
                          underline: SizedBox(),
                          style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,),

                          onChanged: (newValue){
                            setState(() {
                              method = newValue;
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
                  ),
            ],),

              SizedBox(height: 20.0,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Padding(
                    padding : EdgeInsets.fromLTRB(20.0, 25.0, 5.0, 5.0),
                    child: Text("Date :",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),),
                  ),

                  Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(date,
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
                                _showDatePicker(context);
                              },
                            ),
                          ),
                        ],
                      )
                  ),
                ],),

              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: RaisedButton(
                      onPressed: () async {
                        Database db = await DBHelper.instance.db;
                        await db
                            .execute(
                            'insert into mothers (firstName,lastName,pNumber,sNumber,calMethod,calDate,dueDate,archived) values ("$firstName","$lastName","$pNumber","$sNumber", "$method","$date","$dueDate","0")');
                        Navigator.pushReplacementNamed(context, '/');
                        },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text("Add",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                          )),
                      color: Colors.amber,
                    ),
                  ),

                ],
              ),
    ],),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
