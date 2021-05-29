import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/details.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/': (context) => Home(),
    '/details': (context) => Details(),
  },
));





