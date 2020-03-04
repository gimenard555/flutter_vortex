import 'package:flutter/material.dart';
import 'package:flutter_vortex/src/blocs/employee_bloc.dart';
import 'package:flutter_vortex/src/models/employee_model.dart';
import 'package:flutter_vortex/src/utils/utils.dart';

class EmployeeForm extends StatelessWidget {

  EmployeeForm({Key key, this.title}) : super(key: key);

  final String title;

  //Bloc
  final EmployeeBloc _employeeBloc = EmployeeBloc();

  GlobalKey<FormState> keyForm = new GlobalKey();

  TextEditingController names = new TextEditingController();
  TextEditingController lastNames = new TextEditingController();
  TextEditingController id_number = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController salary = new TextEditingController();
  TextEditingController telephone_number = new TextEditingController();
  List<String> selectedIdType = ['CC', 'NIT'];

  BuildContext context ;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Registro de Empleado'),
        ),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(10.0),
            child: new Form(
              key: this.keyForm,
              child: formUI(),
            ),
          ),
        ),
      ),
    );
  }

  // Formato para cada uno de los campos del empleado
  formItemsDesign(icon, item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
    );
  }

  String selectedType = "CC";

  Widget formUI() {
    return Column(
      children: <Widget>[
        //Campo para escribir el nombre con apellidos del empleado
        formItemsDesign(
            Icons.person,
            Column(
              children: <Widget>[
                TextFormField(
                  style: TextStyle(color: Colors.black, fontSize: 13),
                  controller: this.names,
                  decoration: new InputDecoration(
                    labelText: 'Nombres del Empleado:',
                  ),
                  validator: Utils.validateName,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.black, fontSize: 13),
                  controller: this.lastNames,
                  decoration: new InputDecoration(
                    labelText: 'Apellidos del Empleado:',
                  ),
                  validator: Utils.validateName,
                )
              ],
            )),
        //Campo para telefono
        formItemsDesign(
            Icons.phone,
            TextFormField(
              style: TextStyle(color: Colors.black, fontSize: 13),
              controller: this.telephone_number,
              decoration: new InputDecoration(
                labelText: 'Ingrese Telefono del empleado:',
              ),
              keyboardType: TextInputType.phone,
              maxLength: 10,
              validator: Utils.validateTelephoneNumber,
            )),

        // Campo para ingresar el numero de telefono de la persona
        formItemsDesign(
            Icons.account_box,
            Column(
              children: <Widget>[
                DropdownButton<String>(
                  value: this.selectedIdType[0],
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  onChanged: (String data) {
                    this.selectedType = data;
                  },
                  items: this
                      .selectedIdType
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                    );
                  }).toList(),
                ),
                TextFormField(
                  style: TextStyle(color: Colors.black, fontSize: 13),
                  controller: this.id_number,
                  decoration: new InputDecoration(
                    labelText: 'Numero de identificacion del empleado:',
                  ),
                  validator: Utils.validateDNINumber,
                )
              ],
            )),

        formItemsDesign(
            Icons.email,
            TextFormField(
              style: TextStyle(color: Colors.black, fontSize: 13),
              controller: this.email,
              decoration: new InputDecoration(
                labelText: 'Correo Electronico:',
              ),
              keyboardType: TextInputType.emailAddress,
              maxLength: 32,
              //validator: Utils.validateEmail,
            )),
        formItemsDesign(
            Icons.payment,
            TextFormField(
              style: TextStyle(color: Colors.black, fontSize: 13),
              controller: this.salary,
              decoration: InputDecoration(
                labelText: 'Salario del empleado:',
              ),
            )),

        // Cuando se da click en el boton
        GestureDetector(
            onTap: () {
              save();

            },
            child: Container(
              margin: new EdgeInsets.all(10.0),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: Color.fromARGB(255, 255, 0, 128),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              child: Text("ENVIAR",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500)),
              padding: EdgeInsets.only(top: 16, bottom: 16),
            ))
      ],
    );
  }

  //Se guarda la informacion del formulario
  save() {
    if (this.keyForm.currentState.validate()) {
      /*  print("Nombres: ${this.names.text}");
      print("Apellidos: ${this.lastNames.text}");
      print("Numero de Telefono Ingresado: ${this.telephone_number.text}");
      print("${this.selectedType} : ${this.id_number.text}");
      print("Correo Electronico: ${this.email.text}");
      print("Salario del Empleado: ${this.telephone_number.text}");*/
      this._employeeBloc.addTodo(Employee(
          names: this.names.text,
          lastnames: this.lastNames.text,
          id_type: this.selectedType,
          id_number: int.parse(this.id_number.text),
          email: this.email.text,
          salary: this.salary.text,
          telephone: this.telephone_number.text));

      keyForm.currentState.reset();
      Navigator.pop(context);

    }
  }
}
