import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../models/employee_model.dart';
import '../models/telephone_model.dart';

class FirebaseApiProvider {
  Client client = Client();
  final _apiKey = 'your_api_key';

  /*Future<Employee> fetchEmployeeList() async {
    print("entered");
    final response = await client
        .get("http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey");
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }*/
}
