import 'dart:convert';

import 'package:http/http.dart';
import 'package:xth_trimester/dataBase/patient_model.dart';
import 'package:sqflite/sqflite.dart';

import 'package:xth_trimester/dataBase/db_helper.dart';
import 'package:xth_trimester/dataBase/doctor_model.dart';

class DataTransfer {

  createAccount (String email, String pass, String confirmPass)async{
    Database db = await DBHelper.instance.db;
    final msg = jsonEncode({'email': email,'password':pass, 'password2':confirmPass});
    Response responseAuth = await post('http://10.0.2.2:8000/account/register/',
        headers: {'Content-Type': 'application/json'},
        body: msg,);
    Map data_1 = jsonDecode(responseAuth.body);
    print(data_1);

  }
}


