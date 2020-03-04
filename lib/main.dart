import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:flutter_vortex/src/ui/employees_list.dart';

void main(){
  //Stetho.initialize();
  runApp(MaterialApp(
    home: EmployeesPage(),
  ));
}