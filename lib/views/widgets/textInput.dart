import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String hintText;
  final TextEditingController txtController;
  final TextInputType inputType;

  const TextInput({
    Key key, 
    this.hintText,
    this.txtController,
    this.inputType
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _textInput();
  }

  Widget _textInput()
  {
    return TextFormField(
      style: TextStyle(
        color: Colors.red
      ),
      controller: txtController,
      keyboardType: inputType,
      decoration: textBoxDecoration(hintText),
    );
  }

  InputDecoration textBoxDecoration(String hintText)
  {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
        borderRadius: BorderRadius.circular(32.0)
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
}