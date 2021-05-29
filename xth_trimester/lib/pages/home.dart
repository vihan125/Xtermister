import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'patient.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState(){
    super.initState();
    patients = original;
    setupList();
  }

  List<Patient> patients;

  List<Patient> original =[
    Patient(firstName: "Binuri", lastName: "Ranatunga", embryoAge: 70, p_phone: "07xxxxxxxx", s_phone: "011xxxxxxx"),
    Patient(firstName: "Selena", lastName: "Gomez", embryoAge: 266, p_phone: "07xxxxxxxx", s_phone: "011xxxxxxx"),
    Patient(firstName: "Yamuna", lastName: "Kanthi", embryoAge: 90, p_phone: "07xxxxxxxx", s_phone: "011xxxxxxx"),
    Patient(firstName: "Lesly", lastName: "Joshep", embryoAge: 200, p_phone: "07xxxxxxxx", s_phone: "011xxxxxxx"),
    Patient(firstName: "Saduni", lastName: "Ratnayeka", embryoAge: 266, p_phone: "07xxxxxxxx", s_phone: "011xxxxxxx"),
    Patient(firstName: "Alexa", lastName: "Malkanthi", embryoAge: 0, p_phone: "07xxxxxxxx", s_phone: "011xxxxxxx"),
    Patient(firstName: "gagnga", lastName: "Nadee", embryoAge: 175, p_phone: "07xxxxxxxx", s_phone: "011xxxxxxx"),
    Patient(firstName: "Wijayalatha", lastName: "subodanie", embryoAge: 210, p_phone: "07xxxxxxxx", s_phone: "011xxxxxxx"),
    Patient(firstName: "Nikini", lastName: "Perera", embryoAge: 136, p_phone: "07xxxxxxxx", s_phone: "011xxxxxxx"),
  ];

  List<bool> isSelected = [false,false,false,false,false,false,false];

  void setupList(){
    patients.sort((a,b) => b.embryoAge.compareTo(a.embryoAge));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Patients List",
          style: TextStyle(
            fontSize: 25.0,
          ),),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 6.0,),
                    color: Colors.grey[400],
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical:0.0, horizontal:MediaQuery.of(context).size.width/45),
                      child: ToggleButtons(
                        borderWidth: 2.0,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(1.0),
                            child: Icon(Icons.account_box,
                                size: MediaQuery.of(context).size.width/11),
                          ),

                          Container(
                            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/44, 0.0, MediaQuery.of(context).size.width/44, 0.0),
                            child:Image.asset("assets/Red.png", width: MediaQuery.of(context).size.width/11, height:(MediaQuery.of(context).size.width/11)+20,), ),
                          Container(
                            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/44, 0.0, MediaQuery.of(context).size.width/44, 0.0),
                            child:Image.asset("assets/Orange.png", width: MediaQuery.of(context).size.width/11, height:(MediaQuery.of(context).size.width/11)+20,),),
                          Container(
                            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/44, 0.0, MediaQuery.of(context).size.width/44, 0.0),
                            child:Image.asset("assets/Amber.png", width: MediaQuery.of(context).size.width/11, height:(MediaQuery.of(context).size.width/11)+20),),
                          Container(
                            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/44, 0.0, MediaQuery.of(context).size.width/44, 0.0),
                            child:Image.asset("assets/Green.png", width: MediaQuery.of(context).size.width/11, height:(MediaQuery.of(context).size.width/11)+20),),
                          Container(
                            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/44, 0.0, MediaQuery.of(context).size.width/44, 0.0),
                            child:Image.asset("assets/Blue.png", width: MediaQuery.of(context).size.width/11, height:(MediaQuery.of(context).size.width/11)+20),),

                          Padding(
                            padding: EdgeInsets.all(1.0),
                            child: Icon(Icons.add_box,
                              size:MediaQuery.of(context).size.width/11,
                              color: Colors.indigo,),
                          ),
                        ],

                        isSelected: isSelected,
                        color: Colors.red,
                        selectedColor: Colors.green[400],
                        fillColor: Colors.blue[50],
                        highlightColor: Colors.orangeAccent[400],
                        onPressed: (int i){
                          setState(() {
                            if ((i == 0) && (!isSelected[i])) {
                              patients.sort((a, b) => a.embryoAge.compareTo(b.embryoAge));
                              isSelected[i] = !isSelected[i];
                            }
                            else if ((i == 0) && (isSelected[i])) {
                              patients.sort((a, b) => b.embryoAge.compareTo(a.embryoAge));
                              isSelected[i] = !isSelected[i];
                            }

                            else if ((i == 1) && (!isSelected[i])) {
                              List<Patient> filterRed = [];
                              for (int k =0; k < original.length; k++){
                                if (original[k].embryoAge >258){
                                  filterRed.add(original[k]);
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
                              patients = original;
                              isSelected[i] = !isSelected[i];
                            }

                            else if ((i == 2) && (!isSelected[i])) {
                              List<Patient> filterOrange = [];
                              for (int k =0; k < original.length; k++){
                                if ((original[k].embryoAge > 195)&&(original[k].embryoAge <= 258)){
                                  filterOrange.add(original[k]);
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
                              patients = original;
                              isSelected[i] = !isSelected[i];
                            }

                            else if ((i == 3) && (!isSelected[i])) {
                              List<Patient> filterAmber = [];
                              for (int k =0; k < original.length; k++){
                                if ((original[k].embryoAge > 85)&&(original[k].embryoAge <= 195)){
                                  filterAmber.add(original[k]);
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
                              patients = original;
                              isSelected[i] = !isSelected[i];
                            }

                            else if ((i == 4) && (!isSelected[i])) {
                              List<Patient> filterGreen = [];
                              for (int k =0; k < original.length; k++){
                                if ((original[k].embryoAge > 0)&&(original[k].embryoAge <= 84)){
                                  filterGreen.add(original[k]);
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
                              patients = original;
                              isSelected[i] = !isSelected[i];
                            }

                            else if ((i == 5) && (!isSelected[i])) {
                              List<Patient> filterBlue = [];
                              for (int k =0; k < original.length; k++){
                                if (original[k].embryoAge < 1){
                                  filterBlue.add(original[k]);
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
                              patients = original;
                              isSelected[i] = !isSelected[i];
                            }

                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: patients.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    direction: DismissDirection.startToEnd,
                    key: Key(index.toString()),
                    onDismissed: (direction){},
                    background: Container(color: Colors.red),
                    confirmDismiss: (DismissDirection direction)async{
                      return await showDialog(
                        context:context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Delete Comfirmation"),
                            content: Text(" Are you sure you want to remove this patient?"),
                            actions: <Widget>[

                              FlatButton(
                                onPressed: ()=> Navigator.of(context).pop(true),
                                child: Text("Delete"),
                              ),

                              FlatButton(
                                onPressed: ()=>Navigator.of(context).pop(false),
                                child: Text("Cancel"),
                              ),
                            ],
                          );
                        },
                      );
                    },

                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context,"/details",arguments: {'Patient':patients[index]});
                          },
                          title: Text(
                              patients[index].firstName + " " + patients[index].lastName),
                          subtitle: Text(patients[index].ageWeeks),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
      backgroundColor: Colors.grey[600],
    );
  }
}