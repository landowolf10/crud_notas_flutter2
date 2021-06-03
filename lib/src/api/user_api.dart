import 'dart:convert';
import 'package:crud_notas/src/models/user_nodel.dart';
import 'package:http/http.dart' as http;

class UserAPIs
{
  Future<bool> login(String mail, String password) async
  {
    bool logedIn = false;

    final response = await http.post(
      Uri.parse('http://192.168.0.6:3000/login'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String> {
        'correo': mail,
        'pass': password
      }),
    );

    if (response.statusCode == 200)
    {
      var userData = json.decode(response.body);

      if(!userData.isEmpty)
      {
        if(userData['data']['correo'] == mail && userData['data']['password'] == password)
        {
          print(userData);
          logedIn = true;
          //return UserModel.fromJson(jsonDecode(response.body));
        }
      }
    }
    else
    {
      logedIn = true;
    }

    return logedIn;
  }

  Future<UserModel> createUser(String name, String mail, String password) async
  {
    final response = await http.post(
      Uri.parse('http://192.168.0.6:3000/user'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String> {
        'nombre': name,
        'correo': mail,
        'pass': password
      }),
    );

    if (response.statusCode == 200)
    {
      var userRegistered = json.decode(response.body);
    
      return UserModel.fromJson(userRegistered);
    }
    else
    {
      print("Failed to create new user");
      throw Exception("Failed to create new user");
    }
  }
}
