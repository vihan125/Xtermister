import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import 'patient.dart';


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

  void _showDatePicker(ctx,Patient p) {
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
                      setState(() {
                        _chosenDateTime = val;
                        p.cal_time = val;
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
    data = ModalRoute.of(context).settings.arguments;
    Patient p = data['Patient'];
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient Details"),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: Column(
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
                          controller: TextEditingController(text:p.p_phone),
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
                          controller: TextEditingController(text:p.s_phone),
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
                    String url = "0775688616";
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
          Expanded(
            child: Padding(
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
                          canvasColor: Colors.redAccent[100],
                        ),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 70, 0),
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.circular(10)
                          ),

                          child: DropdownButton(
                            isExpanded: true,
                              icon: Icon(Icons.keyboard_arrow_down),
                              value: p.method,
                              iconSize: 20,
                              elevation: 40,
                              underline: SizedBox(),
                              style: TextStyle(color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,),

                              onChanged: (newValue){
                                setState(() {
                                  p.method= newValue;
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
                                Text(p.cal_time.year.toString() +"-"+p.cal_time.month.toString()+"-"+p.cal_time.day.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),),
                                Container(
                                  child: IconButton(
                                    icon: Icon(Icons.mode_edit,
                                    size: 20,),
                                    color: Colors.blueAccent,
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
                ],
              ),
            ),
          ),
        ],
      ),

      backgroundColor: Colors.grey[100],
    );
  }
}
