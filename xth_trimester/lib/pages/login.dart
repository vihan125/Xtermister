import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String username;
  String password;
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
                child: Image.asset("assets/Logo.png"),
              ),
              SizedBox(height:(MediaQuery.of(context).size.height)/20,),

              Container(
                height: 50,
                width: (MediaQuery.of(context).size.width)/1.5,
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Center(
                    child:TextField(
                      onChanged: (String input_1){
                        username = input_1;
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

              SizedBox(height: 30.0,),

              Container(
                height: 50,
                width: (MediaQuery.of(context).size.width)/1.5,
                margin:EdgeInsets.fromLTRB(30, 5, 30, 5) ,
                child: RaisedButton(
                  color: Colors.cyan,
                  textColor: Colors.white,
                  onPressed: (){},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)
                  ),
                  child: Text("Login",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                ),
              ),

              SizedBox(height: 10,),

              RichText(
//                text: TextSpan(
//                  text: 'Here is the ',
//                  style: TextStyle(fontSize: 10, color: Colors.black),
//                  children: <TextSpan>[
                    text :TextSpan(
                        text: 'Forgot Password ?',
                        recognizer: TapGestureRecognizer()
                        ..onTap = () {
                            print('The button is clicked!');
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

              SizedBox(height: 40,),

              RichText(
                text: TextSpan(
                  text: 'New to App ? ',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                  children: <TextSpan>[
                  TextSpan(
                    text: 'Register',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacementNamed(context, '/signup');
                      },
                    style: TextStyle(
                        color: Colors.cyan[300],
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    )),
//                    TextSpan(text: 'text!'),
                  ],
                ),
              ),
            ],
          ),
        ),
    ),
    );
  }
}
