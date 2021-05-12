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
  bool _obscuredText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 180),
                _emailInput(),
                SizedBox(height: 50),
                _passwordInput(),
                SizedBox(height: 50),
                _loginButton(),
                SizedBox(height: 20),
                _registerButton()
              ]
            )
          ],
        )
      ),
    );
  }

  Widget _emailInput()
  {
    return TextFormField(
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
  }

  Widget _passwordInput()
  {
    return TextFormField(
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
        suffix: InkWell(
          onTap: _togglePasswordView,
          child: Icon(Icons.visibility),
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
  }

  Widget _loginButton()
  {
    return ElevatedButton(
      child: Text('Iniciar sesión'),
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        onPrimary: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        textStyle: TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
        shadowColor: Colors.orange,
        elevation: 5
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
    );
  }

  Widget _registerButton()
  {
    return ElevatedButton(
      child: Text('Crear cuenta'),
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        textStyle: TextStyle(
           fontSize: 30,
           color: Colors.white,
           fontWeight: FontWeight.bold
        ),
        shadowColor: Colors.orange,
        elevation: 5
      ),
      onPressed: () async {
        Navigator.pushReplacement(
          context, MaterialPageRoute(
            builder: (BuildContext ctx) => UserRegistration()
          )
        );
      },
    );
  }

  void _togglePasswordView()
  {
    setState(() {
      _obscuredText = !_obscuredText;
    });
  }
}