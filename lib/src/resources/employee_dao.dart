import 'dart:async';
import 'package:flutter_vortex/src/models/employee_model.dart';
import 'database.dart';

class EmployeeDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Agrega un nuevo empleado
  Future<int> createEmployee(Employee employee) async {
    final db = await this.dbProvider.database;
    var result = db.insert(employeeTABLE, employee.toDatabaseJson());
    return result;
  }

  //Actualiza un empleado existente
  Future<int> updateEmployee(Employee employee) async {
    final db = await dbProvider.database;
    return await db.update(employeeTABLE, employee.toDatabaseJson(),
        where: "id = ?", whereArgs: [employee.id_number]);
  }

  //Elimina un empleado por el id
  Future<int> deleteEmployee(int id) async {
    final db = await dbProvider.database;
    return await db.delete(employeeTABLE, where: 'id_number = ?', whereArgs: [id]);
  }

  //Elimina todo los empleados existentes
  Future deleteAllEmployees() async {
    final db = await dbProvider.database;

    return await db.delete(employeeTABLE);
  }

  //Se obtienen todos los empleados de la base de datos
  //Searches if query string was passed
  Future<List<Employee>> getEmployees(
      {List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(employeeTABLE,
            columns: columns,
            where: 'description LIKE ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db.query(employeeTABLE, columns: columns);
    }

    return result.isNotEmpty
        ? result.map((item) => Employee.fromDatabaseJson(item)).toList()
        : [];
  }
}
