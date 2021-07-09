import 'package:crud_notas/src/api/user_api.dart';
import 'package:crud_notas/src/views/login_page.dart';
import 'package:crud_notas/src/utils/messages.dart';
import 'package:flutter/material.dart';

class UserRegistration extends StatefulWidget
{
  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration>
{
  TextEditingController txtName = new TextEditingController();
  TextEditingController txtMail = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();
  UserAPIs user = new UserAPIs();
  Dialogs msg = new Dialogs();
  bool _obscuredText = true;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Center(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 180),
                _nameInput(),
                SizedBox(height: 50),
                _mailInput(),
                SizedBox(height: 50),
                _passwordInput(),
                SizedBox(height: 20),
                _registerButton(),
                SizedBox(height: 20),
                _returnButton()
              ]
            )
          ],
        ),
      ),
    );
  }

  Widget _nameInput()
  {
    return TextFormField(
      style: TextStyle(
        color: Colors.red
      ),
      controller: txtName,
      decoration: txtBoxDecoration('Nombre', Icons.person)
    );
  }

  Widget _mailInput()
  {
    return TextFormField(
      style: TextStyle(
        color: Colors.red
      ),
      controller: txtMail,
      keyboardType: TextInputType.emailAddress,
      decoration: txtBoxDecoration('Email', Icons.mail)
    );
  }

  Widget _passwordInput()
  {
    return TextFormField(
      style: TextStyle(
        color: Colors.red
      ),
      controller: txtPassword,
      obscureText: _obscuredText,
      decoration: txtBoxDecoration('Contraseña', Icons.visibility),
    );
  }

  InputDecoration txtBoxDecoration(String hintText, IconData icon)
  {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
        borderRadius: BorderRadius.circular(32.0)
      ),
      suffix: InkWell(
        onTap: _togglePasswordView,
        child: Icon(icon),
      ),
      hintText: hintText,
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
    );
  }

  Widget _registerButton()
  {
    return ElevatedButton(
      child: Text('Registrar cuenta'),
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        textStyle: TextStyle(
           fontSize: 30,
           color: Colors.white,
           fontWeight: FontWeight.bold
        ),
        shadowColor: Colors.orange,
        elevation: 5
      ),
      onPressed: () async {
        if(txtName.text.isEmpty || txtMail.text.isEmpty || txtPassword.text.isEmpty)
        {
          msg.emptyBoxesDialog(context);
        }
        else
        {
          await user.createUser(txtName.text, txtMail.text, txtPassword.text);
          msg.userCreatedDialog(context);
        }
      },
    );
  }

  Widget _returnButton()
  {
    return ElevatedButton(
      child: Text('Regresar al login'),
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        textStyle: TextStyle(
           fontSize: 30,
           color: Colors.white,
           fontWeight: FontWeight.bold
        ),
        shadowColor: Colors.orange,
        elevation: 5
      ),
      onPressed: () {
        Navigator.pushReplacement(
          context, MaterialPageRoute(
            builder: (BuildContext ctx) => Login()
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