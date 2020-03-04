///
/// Se crea clase POJO como modelo de datos para la tabla de empleados
/// de la base de datos*/
class Employee {
  String names;
  String lastnames;
  String id_type;
  int id_number;
  String email;
  String salary;
  String telephone;

  /// Constructor con datos principales del empleado*/
  Employee(
      {this.names,
      this.lastnames,
      this.id_type,
      this.id_number,
      this.email,
      this.salary,
      this.telephone});

  Employee.map(dynamic obj) {
    this.names = obj['names'];
    this.lastnames = obj['lastnames'];
    this.id_type = obj['id_type'];
    this.id_number = obj['id_number'];
    this.email = obj['email'];
    this.salary = obj['salary'];
    this.telephone = obj['telephone'];
  }

  factory Employee.fromDatabaseJson(Map<String, dynamic> data) => Employee(
      names: data['names'],
      lastnames: data['lastnames'],
      id_type: data['id_type'],
      id_number: int.parse(data['id_number']),
      email: data['email'],
      salary: data['salary'],
      telephone: data['telephone']);

  Map<String, dynamic> toDatabaseJson() => {
        "names": this.names,
        "lastNames": this.lastnames,
        "id_type": this.id_type,
        "id_number": this.id_number,
        "email": this.email,
        "salary": this.salary,
        "telephone": this.telephone
      };
}
