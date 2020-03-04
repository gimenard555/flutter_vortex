class Telephone {
  int _employee_id_pk;
  String _telephone_number;

  Telephone(this._employee_id_pk, this._telephone_number);

  int get employee_id_pk => this._employee_id_pk;

  String get telephone_number => this._telephone_number;

  Telephone.map(dynamic obj) {
    this._employee_id_pk = obj['employee_id_pk'];
    this._telephone_number = obj['telephone_number'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["employee_id_pk"] = this._employee_id_pk;
    map["telephone_number"] = this._telephone_number;
    return map;
  }
}
