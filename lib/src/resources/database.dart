import 'dart:io';
import '../models/employee_model.dart';
import '../models/telephone_model.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final employeeTABLE = 'EMPLOYEE';
final telephoneTABLE = 'TELEPHONE';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "ReactiveEmployee.db");
    return await openDatabase(path, version: 1, onCreate: initDB, onUpgrade: onUpgrade);
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $employeeTABLE ("
        "names TEXT,"
        "lastnames TEXT,"
        "id_type TEXT,"
        "id_number TEXT,"
        "email TEXT,"
        "salary TEXT,"
        "telephone TEXT); "
        "CREATE TABLE $telephoneTABLE("
        "   id_telephone INTEGER PRIMARY KEY,"
        "  employee_id_pk TEXT,"
        " telephone_number TEXT);");
  }
}
