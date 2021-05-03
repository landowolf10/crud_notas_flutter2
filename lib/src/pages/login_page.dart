import 'package:crud_notas/src/api/user_api.dart';
import 'package:crud_notas/src/pages/user_registration_page.dart';
import 'package:crud_notas/src/utils/messages.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController txtUser = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();
  UserAPIs user = new UserAPIs();
  Dialogs msg = new Dialogs();

  @override
  Widget build(BuildContext context) {
    bool _obscuredText = true;

    final emailInput = TextFormField(
      style: TextStyle(
        color: Colors.red
      ),
      controller: txtUser,
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
          borderRadius: BorderRadius.circular(32.0)
        ),
        hintText: 'Correo',
        hintStyle: TextStyle(
          color: Colors.red
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(
            color: Colors.orange,
            width: 2.0
          )
        )
      ),
    );

    final passwordInput = TextFormField(
      style: TextStyle(
        color: Colors.red
      ),
      controller: txtPassword,
      autofocus: false,
      obscureText: _obscuredText,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
          borderRadius: BorderRadius.circular(32.0)
        ),
        suffixIcon: IconButton(
          color: Colors.red,
          onPressed: () {
            setState(() {
              if(_obscuredText)
                _obscuredText = false;
              else
                _obscuredText = true;

              print(_obscuredText);
            });
          },
          icon: Icon(Icons.lock),
        ),
        hintText: 'Contraseña',
        hintStyle: TextStyle(
          color: Colors.red
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(
            color: Colors.orange,
            width: 2.0
          )
        )
      ),
    );

    //padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),

    final loginButton = ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 10, height: 40),
      child: ElevatedButton(
        child: Text('Iniciar sesión'),
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
          textStyle: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold
          )
        ),
        onPressed: () async {
          if(txtUser.text.isEmpty || txtPassword.text.isEmpty)
          {
            msg.emptyBoxesDialog(context);
          }
          else
          {
            var logedIn = await user.login(txtUser.text, txtPassword.text);

            if(logedIn)
              print('Redirigir al menu de notas');
            else
              msg.invalidLoginDialog(context);
          }
        },
      )
    );

    final registerButton = ElevatedButton(
      child: Text('Crear cuenta'),
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        textStyle: TextStyle(
           fontSize: 30,
           color: Colors.white,
           fontWeight: FontWeight.bold
        )
      ),
      onPressed: () async {
        Navigator.pushReplacement(
          context, MaterialPageRoute(
            builder: (BuildContext ctx) => UserRegistration()
          )
        );
      },
    );

    final prueba = ElevatedButton(
      child: Text('Prueba'),
      onPressed: (){},
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
          child: ListView(
            children: [
              SizedBox(height: 180),
              emailInput,
              SizedBox(height: 50),
              passwordInput,
              SizedBox(height: 50),
              loginButton,
              SizedBox(height: 20),
              registerButton,
              SizedBox(height: 20),
              prueba
            ],
          ),
      ),
    );
  }
}