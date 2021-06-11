import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'patient.dart';
import 'package:xth_trimester/dataBase/db_helper.dart';
import 'package:xth_trimester/dataBase/patient_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xth_trimester/pages/search.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin{

  Widget display;
  int length = -1 ;
  @override
  void initState(){
    super.initState();
    getData();
  }

  List <Mother> Mothers=[];
  List<Mother> patients=[];

  void setupList(){
    patients.sort((a,b) => b.embryoAge.compareTo(a.embryoAge));
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
        Mothers.add(m);
      }
      setState(() {
        patients = Mothers;
        setupList();
      });
    }
    //print(patients);
  }


  List<bool> isSelected = [false,false,false,false,false,false];

  Widget home() {
    return Scaffold(
      appBar: AppBar(
        leading:Builder(
            builder: (BuildContext context){
              return IconButton(
                icon: Icon(Icons.add),
                onPressed: (){
                  Navigator.pushReplacementNamed(context, '/add');
                },
                color: Colors.white,
              );
            }
        ),
        elevation: 0,
        title: Text("Patients",
          style: TextStyle(
            fontSize: 20.0,
          ),),
        centerTitle: true,
        backgroundColor: Colors.cyan[200],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed:(){
              showSearch(context: context, delegate: PatientSearch(Mothers));
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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 10.0),
                          child: ToggleButtons(
                            borderWidth: 7.0,
                            borderColor: Colors.transparent,
                            borderRadius: BorderRadius.circular(10.0),
                            children: <Widget>[

                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 44, 0.0, MediaQuery.of(context).size.width / 44, 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(8.0)),
                                  child: Image.asset(
                                  "assets/sort.png", width: MediaQuery.of(context).size.width / 11, height: (MediaQuery.of(context).size.width / 11) + 20,),),
                              ),

                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 44, 0.0, MediaQuery.of(context).size.width / 44, 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20.0)),
                                  child: Image.asset(
                                  "assets/Red.png", width: MediaQuery.of(context).size.width / 11, height: (MediaQuery.of(context).size.width / 11) + 20,),),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 44, 0.0, MediaQuery.of(context).size.width / 44, 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20.0)),
                                  child: Image.asset(
                                  "assets/Orange.png", width: MediaQuery.of(context).size.width / 11, height: (MediaQuery.of(context).size.width / 11) + 20,),),
                                ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 44, 0.0, MediaQuery.of(context).size.width / 44, 0.0),
                                 child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20.0)),
                                  child: Image.asset(
                                    "assets/Amber.png", width: MediaQuery.of(context).size.width / 11, height: (MediaQuery.of(context).size.width / 11) + 20,),),
                                ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 44, 0.0, MediaQuery.of(context).size.width / 44, 0.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0)),
                                    child: Image.asset(
                                    "assets/Green.png", width: MediaQuery.of(context).size.width / 11, height: (MediaQuery.of(context).size.width / 11) + 20,),),
                               ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 44, 0.0, MediaQuery.of(context).size.width / 44, 0.0),
                                child: ClipRRect(
                                  borderRadius:BorderRadius.all(
                                      Radius.circular(20.0)),
                                  child: Image.asset(
                                    "assets/Blue.png", width: MediaQuery.of(context).size.width / 11, height: (MediaQuery.of(context).size.width / 11) + 20,),),
                              ),

                            ],

                            isSelected: isSelected,
                            onPressed: (int i) {
                              setState(() {
                                if ((i == 0) && (!isSelected[i])) {
                                  if ((!isSelected[1]) && (!isSelected[2]) && (!isSelected[3]) && (!isSelected[4]) && (!isSelected[5])) {
                                    patients.sort((a, b) =>
                                        a.embryoAge.compareTo(b.embryoAge));
                                    isSelected[i] = !isSelected[i];
                                  }
                                }
                                else if ((i == 0) && (isSelected[i])) {
                                  if ((!isSelected[1]) && (!isSelected[2]) && (!isSelected[3]) && (!isSelected[4]) && (!isSelected[5])){
                                    patients.sort((a, b) =>
                                        b.embryoAge.compareTo(a.embryoAge));
                                    isSelected[i] = !isSelected[i];
                                  }

                                }

                                else if ((i == 1) && (!isSelected[i])) {
                                  List<Mother> filterRed = [];
                                  for (int k = 0; k < Mothers.length; k++) {
                                    if (Mothers[k].embryoAge > 258) {
                                      filterRed.add(Mothers[k]);
                                    }
                                  }
                                  patients = filterRed;
                                  isSelected[i] = !isSelected[i];
                                  isSelected[2] = false;
                                  isSelected[3] = false;
                                  isSelected[4] = false;
                                  isSelected[5] = false;
                                }

                                else if ((i == 1) && (isSelected[i])) {
                                  patients = Mothers;
                                  isSelected[i] = !isSelected[i];
                                }

                                else if ((i == 2) && (!isSelected[i])) {
                                  List<Mother> filterOrange = [];
                                  for (int k = 0; k < Mothers.length; k++) {
                                    if ((Mothers[k].embryoAge > 195) &&
                                        (Mothers[k].embryoAge <= 258)) {
                                      filterOrange.add(Mothers[k]);
                                    }
                                  }
                                  patients = filterOrange;
                                  isSelected[i] = !isSelected[i];
                                  isSelected[1] = false;
                                  isSelected[3] = false;
                                  isSelected[4] = false;
                                  isSelected[5] = false;
                                }

                                else if ((i == 2) && (isSelected[i])) {
                                  patients = Mothers;
                                  isSelected[i] = !isSelected[i];
                                }

                                else if ((i == 3) && (!isSelected[i])) {
                                  List<Mother> filterAmber = [];
                                  for (int k = 0; k < Mothers.length; k++) {
                                    if ((Mothers[k].embryoAge > 85) &&
                                        (Mothers[k].embryoAge <= 195)) {
                                      filterAmber.add(Mothers[k]);
                                    }
                                  }
                                  patients = filterAmber;
                                  isSelected[i] = !isSelected[i];
                                  isSelected[1] = false;
                                  isSelected[2] = false;
                                  isSelected[4] = false;
                                  isSelected[5] = false;
                                }

                                else if ((i == 3) && (isSelected[i])) {
                                  patients = Mothers;
                                  isSelected[i] = !isSelected[i];
                                }

                                else if ((i == 4) && (!isSelected[i])) {
                                  List<Mother> filterGreen = [];
                                  for (int k = 0; k < Mothers.length; k++) {
                                    if ((Mothers[k].embryoAge > 0) &&
                                        (Mothers[k].embryoAge <= 84)) {
                                      filterGreen.add(Mothers[k]);
                                    }
                                  }
                                  patients = filterGreen;
                                  isSelected[i] = !isSelected[i];
                                  isSelected[1] = false;
                                  isSelected[2] = false;
                                  isSelected[3] = false;
                                  isSelected[5] = false;
                                }

                                else if ((i == 4) && (isSelected[i])) {
                                  patients = Mothers;
                                  isSelected[i] = !isSelected[i];
                                }

                                else if ((i == 5) && (!isSelected[i])) {
                                  List<Mother> filterBlue = [];
                                  for (int k = 0; k < Mothers.length; k++) {
                                    if (Mothers[k].embryoAge < 1) {
                                      filterBlue.add(Mothers[k]);
                                    }
                                  }
                                  patients = filterBlue;
                                  isSelected[i] = !isSelected[i];
                                  isSelected[1] = false;
                                  isSelected[2] = false;
                                  isSelected[3] = false;
                                  isSelected[4] = false;
                                }

                                else if ((i == 5) && (isSelected[i])) {
                                  patients = Mothers;
                                  isSelected[i] = !isSelected[i];
                                }
                              });
                            },
                          ),
                      ),

                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: patients.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      direction: DismissDirection.startToEnd,
                      key: UniqueKey(),
                      onDismissed: (direction) async {
                        var id = patients[index].id;
                        Database db = await DBHelper.instance.db;
                        await db.execute('DELETE FROM mothers where id = "$id"');
                        Mothers.removeAt(index);
                      },
                      background: Container(color: Colors.red),
                      confirmDismiss: (DismissDirection direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Delete Comfirmation"),
                              content: Text(
                                  " Are you sure you want to remove this patient?"),
                              actions: <Widget>[

                                FlatButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: Text("Delete"),
                                ),

                                FlatButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text("Cancel"),
                                ),
                              ],
                            );
                          },
                        );
                      },

                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 4.0),
                        child: Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, "/details",
                                  arguments: {'Patient': patients[index],'changed':false});
                            },
                            title: Text(
                                patients[index].firstName + " " +
                                    patients[index].lastName),
                            subtitle: Text(patients[index].ageWeeks),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(8.0)),
                              child: Image.asset(patients[index].icon),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]
        ),
      ),
      backgroundColor: Colors.white,

    );
  }



    @override
    Widget build(BuildContext context) {
      super.build(context);
      return home();
    }

  @override
  bool get wantKeepAlive => true;
  }
