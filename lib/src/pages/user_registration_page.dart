import 'package:crud_notas/src/api/user_api.dart';
import 'package:crud_notas/src/pages/login_page.dart';
import 'package:crud_notas/src/utils/messages.dart';
import 'package:flutter/material.dart';

class UserRegistration extends StatefulWidget {
  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  TextEditingController txtName = new TextEditingController();
  TextEditingController txtMail = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();
  UserAPIs user = new UserAPIs();
  Dialogs msg = new Dialogs();

  @override
  Widget build(BuildContext context) {
    bool _obscuredText = true;

    final nameInput = TextFormField(
      style: TextStyle(
        color: Colors.red
      ),
      controller: txtName,
      autofocus: true,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
          borderRadius: BorderRadius.circular(32.0)
        ),
        hintText: 'Nombre',
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


    final mailInput = TextFormField(
      style: TextStyle(
        color: Colors.red
      ),
      controller: txtMail,
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
          borderRadius: BorderRadius.circular(32.0)
        ),
        hintText: 'Email',
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

    Widget passwordInput = TextFormField(
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

    final registerButton = ElevatedButton(
      child: Text('Registrar cuenta'),
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        textStyle: TextStyle(
           fontSize: 30,
           color: Colors.white,
           fontWeight: FontWeight.bold
        )
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

    final returnButton = ElevatedButton(
      child: Text('Regresar al login'),
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        textStyle: TextStyle(
           fontSize: 30,
           color: Colors.white,
           fontWeight: FontWeight.bold
        )
      ),
      onPressed: () {
        Navigator.pushReplacement(
          context, MaterialPageRoute(
            builder: (BuildContext ctx) => Login()
          )
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Center(
          child: ListView(
            children: [
              SizedBox(height: 180),
              nameInput,
              SizedBox(height: 50),
              mailInput,
              SizedBox(height: 50),
              passwordInput,
              SizedBox(height: 20),
              registerButton,
              SizedBox(height: 20),
              returnButton
            ],
          ),
      ),
    );
  }
}