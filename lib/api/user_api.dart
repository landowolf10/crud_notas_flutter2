import 'dart:convert';
import 'package:crud_notas/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserAPIs
{
  String url = 'http://192.168.0.11:3000';

  Future<Map<String, dynamic>> login(String mail, String password) async
  {
    bool logedIn = false;
    Map<String, dynamic> userObj = {};

    final response = await http.post(
      Uri.parse(url + '/user/login'),
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

      if(userData.containsKey('user_data'))
      {
        if(userData['user_data']['correo'] == mail && userData['user_data']['pass'] == password)
        {
          logedIn = true;

          userObj = {
            "user_id": userData['user_data']['id'],
            "user_name": userData['user_data']['nombre']
          };
          //return UserModel.fromJson(jsonDecode(response.body));
        }
      }
    }
    else
    {
      logedIn = false;
    }

    userObj['logged_in'] = logedIn;

    print(userObj);

    return userObj;
  }

  Future<UserModel> createUser(String name, String mail, String password) async
  {
    final response = await http.post(
      Uri.parse(url + '/user'),
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
