import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:xth_trimester/dataBase/dataTransfer.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  String email;
  String password;
  String confirmPass;
  bool hidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
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
              SizedBox(height:(MediaQuery.of(context).size.height)/10,),

              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: Text("Create an Account",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),),
              ),
              SizedBox(height:(MediaQuery.of(context).size.height)/20,),

              Container(
                height: 50,
                width: (MediaQuery.of(context).size.width)/1.5,
                margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Center(
                  child:TextField(
                    onChanged: (String input_1){
                      email = input_1;
                    },
                    decoration: InputDecoration(
                        hintText: 'Email',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: BorderSide(width:3,color: Colors.cyan[300]),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: BorderSide(width:3,color: Colors.cyan),
                        ),
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        suffixIcon: Icon(Icons.email,
                          color: Colors.black87,)
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              Container(
                height: 50,
                width: (MediaQuery.of(context).size.width)/1.5,
                margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Center(

                  child:TextField(
                    onChanged: (String input_2){
                      password = input_2;
                    },
                    decoration: InputDecoration(
                        hintText: 'Password',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: BorderSide(width:3,color: Colors.cyan[300]),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: BorderSide(width:3,color: Colors.cyan),
                        ),
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        suffixIcon: IconButton(icon: Icon(Icons.lock_outline,),
                        color: Colors.black87,
                        tooltip: "View Password",
                        onPressed: (){
                          setState(() {
                            if (hidden){
                              hidden = false;
                            }else {
                              hidden = true;
                            }
                          });
                        },)

                    ),
                    obscureText: hidden,
                  ),
                ),
              ),

              SizedBox(height: 20.0,),

              Container(
                height: 50,
                width: (MediaQuery.of(context).size.width)/1.5,
                margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Center(

                  child:TextField(
                    onChanged: (String input_3){
                      confirmPass = input_3;
                    },
                    decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: BorderSide(width:3,color: Colors.cyan[300]),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: BorderSide(width:3,color: Colors.cyan),
                        ),
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        suffixIcon: IconButton(icon: Icon(Icons.lock_outline,),
                          color: Colors.black87,
                          tooltip: "View Password",
                          onPressed: (){
                            setState(() {
                              if (hidden){
                                hidden = false;
                              }else {
                                hidden = true;
                              }
                            });
                          },)

                    ),
                    obscureText: hidden,
                  ),
                ),
              ),

              SizedBox(height: 30.0,),

              Container(
                height: 50,
                width: (MediaQuery.of(context).size.width)/1.5,
                margin:EdgeInsets.fromLTRB(30, 5, 30, 5) ,
                child: RaisedButton(
                  color: Colors.cyan,
                  textColor: Colors.white,
                  onPressed: (){
                    DataTransfer dt = new DataTransfer();
                    dt.createAccount(email, password, confirmPass);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)
                  ),
                  child: Text("Register",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                ),
              ),

              SizedBox(height: 20,),

              RichText(
//                text: TextSpan(
//                  text: 'Here is the ',
//                  style: TextStyle(fontSize: 10, color: Colors.black),
//                  children: <TextSpan>[
                text :TextSpan(
                    text: 'Already have an account ?',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                    style: TextStyle(
                        color: Colors.cyan[300],
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    )),
//                    TextSpan(text: 'text!'),
//                  ],
//                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
