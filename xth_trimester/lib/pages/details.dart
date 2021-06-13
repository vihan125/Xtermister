import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xth_trimester/dataBase/db_helper.dart';
//import 'patient.dart';
import 'package:xth_trimester/dataBase/patient_model.dart';
import 'package:xth_trimester/pages/patient.dart';
import 'package:xth_trimester/pages/show_aleart.dart';


class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  Map data = {};
  bool isEnabled =  false;
  InputDecoration decorationEdit = InputDecoration(fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0))
  );

  InputDecoration decorationShow = InputDecoration(border: InputBorder.none);

  List<String> _methods = ['LMP','CD','US','EDC','Born'];
  DateTime _chosenDateTime;
  Mother p;
  String msg;
  InputDecoration decoration;

  String fName;
  String lName;
  String pNo;
  String sNo;
  String note;

  TextEditingController firstNameCtrl;
  TextEditingController lastNameCtrl;
  TextEditingController pNoCtrl;
  TextEditingController sNoCtrl;
  TextEditingController notesCtrl;



  @override
  void initState() {
    super.initState();
    firstNameCtrl = TextEditingController();

    lastNameCtrl = TextEditingController();

    pNoCtrl = TextEditingController();

    sNoCtrl = TextEditingController();

    notesCtrl = TextEditingController();

  }

  void dispose(){
    super.dispose();
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    pNoCtrl.dispose();
    sNoCtrl.dispose();
    notesCtrl.dispose();
  }
  var backBtn_1 =  Builder(
      builder: (BuildContext context){
      return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: (){
          Navigator.pop(context);
          },
        color: Colors.white,
        );
        }
      );

  var backBtn_2 =  Builder(
      builder: (BuildContext context){
        return IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pushReplacementNamed(context,'/');
          },
          color: Colors.white,
        );
      }
  );

  var backBtn;
  bool changed;


  void setBack (){
    if(changed){
      backBtn = backBtn_2;
    }else{
      backBtn = backBtn_1;
    }
  }

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
                        _chosenDateTime = val;

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
                      arguments: {'Patient': m , 'changed':true, 'message':"Patient updated Successfully"});
                },
              )
            ],
          ),
        ));
  }

  void setEdit (Mother p)async{
    if (isEnabled){
      int id = p.id;
      Database db = await DBHelper.instance.db;
      if(fName != null){
        if(fName != ""){
          await db.execute('UPDATE mothers SET firstName = "$fName" WHERE id = $id');
          setState(() {
            p.firstName = fName;
          });
        }else{
          showError(context, "Name field cannot be empty");
        }

      }

      if (lName != null){
        await db.execute('UPDATE mothers SET lastName = "$lName" WHERE id = $id');
        setState(() {
          p.lastName = lName;
        });
      }

      if (pNo != null){
        if(pNo != ""){
          await db.execute('UPDATE mothers SET pNumber = "$pNo" WHERE id = $id');
          setState(() {
            p.pNumber = pNo;
          });
        }else{
          showError(context, "Primary Contact cannot be empty");

        }
      }

      if (sNo != null){
        await db.execute('UPDATE mothers SET sNumber  = "$sNo" WHERE id = $id');
        setState(() {
          p.sNumber = sNo;
        });
      }

      setState(() {
          isEnabled = false;
        });

    }else{
      setState(() {
        isEnabled = true;
      });
    }
  }

  void setDeco (){
    if (isEnabled){
        decoration = decorationEdit;
    }else{
        decoration = decorationShow;
    }
  }



  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    p = data['Patient'];
    changed = data['changed'];
    msg = data['message'];
    if((msg != "") && (msg != null)){
      showSuccess(context, msg);
    }
    if ((fName ==null) && (lName == null) && (pNo == null) && (sNo == null) && (note == null)){
      fName = p.firstName;
      lName = p.lastName;
      pNo = p.pNumber;
      sNo = p.sNumber;

      firstNameCtrl.text = fName;

      lastNameCtrl.text = lName;

      pNoCtrl.text = pNo;

      sNoCtrl.text = sNo;

      if (p.notes != null ){
        note = p.notes;
        notesCtrl.text = note;
      }
    }
    setBack();
    setDeco();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: backBtn,
          title: Text("Patient Details"),
          centerTitle: true,
          backgroundColor: Colors.cyan[200],
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed:(){
                  setEdit(p);
              } ,
              color: Colors.white,),
          ],
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
                             height: 30,
                             width: ((MediaQuery.of(context).size.width)/2)-10,
                             child: TextField(
                                style: TextStyle(
                                  fontSize:20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                 controller: firstNameCtrl,
                                 autofocus: true,
                                 enabled: isEnabled,
                                  decoration: decoration,
                               onChanged: (fN) async {
                                  if(fN != "") {
                                    fName = fN;
                                    firstNameCtrl.text = fName;
                                    firstNameCtrl.selection = TextSelection.fromPosition(TextPosition(offset: firstNameCtrl.text.length));
                                  }
                               },
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
                             height: 30,
                             width: ((MediaQuery.of(context).size.width)/2)-10,
                             child: TextField(
                               style: TextStyle(
                                 fontSize:20,
                                 color: Colors.black,
                                 fontWeight: FontWeight.bold,
                               ),
                               controller: lastNameCtrl,
                               enabled: isEnabled,
                               decoration: decoration,
                               onChanged: (lN) async {
                                 lName = lN;
                                 lastNameCtrl.text = lName;
                                 lastNameCtrl.selection = TextSelection.fromPosition(TextPosition(offset: lastNameCtrl.text.length));
                               },
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
                              height: 30,
                              width: ((MediaQuery.of(context).size.width)/2)-30,
                              child: TextField(
                                style: TextStyle(
                                  fontSize:20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                controller: pNoCtrl,
                                enabled: isEnabled,
                                decoration: decoration,
                                onChanged: (pN) async {
                                  if(pN != "") {
                                    pNo = pN;
                                    pNoCtrl.text = pNo;
                                    pNoCtrl.selection = TextSelection.fromPosition(TextPosition(offset: pNoCtrl.text.length));
                                  }
                                },
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
                              height: 30,
                              width: ((MediaQuery.of(context).size.width)/2)-30,
                              child: TextField(
                                style: TextStyle(
                                  fontSize:20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                controller: sNoCtrl,
                                enabled: isEnabled,
                                decoration: decoration,
                                onChanged: (sN) async {
                                  sNo=sN;
                                  sNoCtrl.text = sNo;
                                  sNoCtrl.selection = TextSelection.fromPosition(TextPosition(offset: sNoCtrl.text.length));
                                },
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
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: ()async{
                          int id = p.id;
                          Database db = await DBHelper.instance.db;
                          await db.execute('UPDATE mothers SET archived = "1",embryoAge = "-1" WHERE id = $id');
                          var mom = await db.rawQuery('select * from mothers where id = $id');
                          Mother m = Mother.fromMap(mom[0]);
                          Navigator.pushReplacementNamed(context, "/details",
                              arguments: {'Patient': m , 'changed':true, 'message':"Patient archived successfully"});
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
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
                          borderRadius: BorderRadius.circular(30)
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

                  SizedBox(height: 40,),

                  Container(
                    height: 50,
                    child: AppBar(
                      backgroundColor: Colors.white,
                     elevation: 0,
                     bottom: TabBar(
                       indicator: BoxDecoration(
                         borderRadius: BorderRadius.circular(30),
                         color: Colors.cyan[200],
                       ),
                       indicatorColor: Colors.white,
                       labelColor: Colors.white,
                       unselectedLabelColor: Colors.grey,
                       tabs: <Widget>[
                         Tab(icon: Icon(Icons.insert_chart),),
                         Tab(icon: Icon(Icons.note_add),),
                       ],
                     ),
                 ),
                  ),

                 SizedBox(height: 40,),

                 Container(
                   height: (MediaQuery.of(context).size.height),
                   child: TabBarView(
                     children: <Widget>[

                        Padding(
                           padding: EdgeInsets.all(5.0),
                           child: Table(
                             columnWidths: {
                               0: FlexColumnWidth(1),
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
                                       padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                                       decoration: BoxDecoration(
                                           color: Colors.cyan[200],
                                           borderRadius: BorderRadius.circular(20)
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
                                     padding: EdgeInsets.fromLTRB(0,30,0,0),
                                     child: Text("Estimated Due Date",
                                       style: TextStyle(fontSize: 15.0,
                                           color: Colors.grey[800]),),
                                   )),
                                   Padding(
                                     padding: EdgeInsets.fromLTRB(10,30,0,0),
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

                      Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(20,10,20,10),
                            height: 300,
                            child: TextField(
                              maxLines: 30,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                labelText: 'Add notes about patient',
                                labelStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blueGrey,
                                )
                              ),
                              style: TextStyle(
                                fontSize:15,
                                color: Colors.black,
                              ),
                              controller: notesCtrl,
                              enabled: true,
                              onChanged: (input)async {
                                if (input != "") {
                                  note = input;
                                  notesCtrl.text = note;
                                  notesCtrl.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset: notesCtrl.text.length));
                                }

                              }
                            ),
                          ),

                          Padding(
                                padding: EdgeInsets.all(5.0),
                                child: RaisedButton(
                                  color: Colors.cyan[200],
                                  textColor: Colors.white,
                                  onPressed: ()async{
                                    int id = p.id;
                                    Database db = await DBHelper.instance.db;
                                    await db.execute('UPDATE mothers SET notes = "$note" WHERE id = $id');
                                    showSuccess(context, "Note saved successfully");
                                    p.notes = note;

                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                                  child: Text("Save",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                ),
                              ),
                        ],
                      ),

                     ],
                   ),
                 ),

                SizedBox(height: 30,),
              ],
            ),
          ),
        ),

        backgroundColor: Colors.white,
      ),
    );
  }
}
