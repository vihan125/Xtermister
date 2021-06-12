import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/details.dart';
import 'pages/addPatient.dart';
import 'pages/navigator.dart';
import 'pages/calender.dart';
import 'pages/login.dart';
import 'pages/signup.dart';



void main(){

  bool loggedIn = false;

  if(loggedIn) {
    runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MyNavigator(),
        '/home': (context) => Home(),
        '/details': (context) => Details(),
        '/add': (context) => AddPatient(),
        '/calendar': (context) => Calender(),
        '/login': (context) => Login(),
        '/signup': (context) => Signup(),

      },
    )
    );
  }else{
    runApp(MaterialApp(
      initialRoute: '/login',
        routes: {
        '/': (context) => MyNavigator(),
        '/home': (context) => Home(),
        '/details': (context) => Details(),
        '/add': (context) => AddPatient(),
        '/calendar': (context) => Calender(),
          '/login': (context) => Login(),
          '/signup': (context) => Signup(),

        },
    ));
  }

}





