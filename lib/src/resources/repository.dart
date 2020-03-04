import 'dart:async';
import 'package:flutter_vortex/src/models/employee_model.dart';
import 'package:flutter_vortex/src/resources/employee_dao.dart';

class EmployeeRepository {
  final employeeDao = EmployeeDao();

  Future getAllEmployees({String query}) => employeeDao.getEmployees(query: query);

  Future insertEmployee(Employee employee) =>
      this.employeeDao.createEmployee(employee);

  Future updateEmployee(Employee employee) =>
      this.employeeDao.updateEmployee(employee);

  Future deleteEmployeeById(int id) => this.employeeDao.deleteEmployee(id);

  Future deleteAllEmployees() => this.employeeDao.deleteAllEmployees();
}
