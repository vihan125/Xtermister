import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/details.dart';
import 'pages/addPatient.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/': (context) => Home(),
    '/details': (context) => Details(),
    '/add': (context) => AddPatient(),
  },
));





