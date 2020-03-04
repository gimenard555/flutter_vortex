import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vortex/src/blocs/employee_bloc.dart';
import 'package:flutter_vortex/src/models/employee_model.dart';

import 'employee_form.dart';

class EmployeesPage extends StatelessWidget {
  EmployeesPage({Key key, this.title}) : super(key: key);

  final EmployeeBloc employeeBloc = EmployeeBloc();
  final String title;

  final DismissDirection _dismissDirection = DismissDirection.horizontal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          title: new Text('Lista de Empleados'),
        ),
        body: SafeArea(
            child: Container(
                ///TODO
                padding:
                    const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
                child: Container(child: getEmployeesWidget()))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        //TODO FLOATING BUTTON PARA AÑADIR EL EMPLEADO
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: FloatingActionButton(
            elevation: 5.0,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmployeeForm()),
              );
            },
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add,
              size: 32,
              color: Color.fromARGB(255, 255, 0, 128),
            ),
          ),
        ));
  }

  Widget getEmployeesWidget() {
    return StreamBuilder(
      stream: employeeBloc.employees,
      builder: (BuildContext context, AsyncSnapshot<List<Employee>> snapshot) {
        return getEmployeeCardWidget(snapshot);
      },
    );
  }

  Widget getEmployeeCardWidget(AsyncSnapshot<List<Employee>> snapshot) {
    if (snapshot.hasData) {
      return snapshot.data.length != 0
          ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, itemPosition) {
                Employee employee = snapshot.data[itemPosition];
                final Widget dismissibleCard = new Dismissible(
                  background: Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Eliminando Empleado....",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    color: Colors.redAccent,
                  ),
                  onDismissed: (direction) {
                    this.employeeBloc.deleteEmployeeById(employee.id_number);
                  },
                  direction: _dismissDirection,
                  key: new ObjectKey(employee),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey[200], width: 0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Colors.white,
                      child: ListTile(
                        /*leading: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {},
                          child: Container(
                            width: 10,
                            height: 10,
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                            alignment: Alignment.center,
                            child: CircleAvatar(),
                          ), TODO CAMBIAR PARA TENER DETECTOR DE TEXTO
                        ),*/
                        title: Text(
                            "${employee.id_type}:${employee.id_number} - ${employee.names} ${employee.lastnames}"),
                        dense: false,
                      )),
                );

                return dismissibleCard;
              },
            )
          : Container(
              child: Center(
              child: noEmployeesMessageWidget(),
            ));
    } else {
      return Center(
        child: loadingData(),
      );
    }
  }

  Widget loadingData() {
    employeeBloc.getEmployees();
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Cargando...",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget noEmployeesMessageWidget() {
    return Container(
      child: Text(
        "Ingrese un Empleado para empezar.....",
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
      ),
    );
  }

  dispose() {
    this.employeeBloc.dispose();
  }
}
