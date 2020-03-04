import 'dart:async';

import 'package:flutter_vortex/src/models/employee_model.dart';
import 'package:flutter_vortex/src/resources/repository.dart';

class EmployeeBloc {
  final _employee_repository = EmployeeRepository();

  final _employee_Controller = StreamController<List<Employee>>.broadcast();

  get employees => this._employee_Controller.stream;

  EmployeeBloc() {
    getEmployees();
  }

  getEmployees({String query}) async {
    _employee_Controller.sink
        .add(await this._employee_repository.getAllEmployees(query: query));
  }

  addTodo(Employee employee) async {
    await this._employee_repository.insertEmployee(employee);
    getEmployees();
  }

  updateTodo(Employee employee) async {
    await this._employee_repository.updateEmployee(employee);
    getEmployees();
  }

  deleteEmployeeById(int id) async {
    this._employee_repository.deleteEmployeeById(id);
    getEmployees();
  }

  dispose() {
    this._employee_Controller.close();
  }
}