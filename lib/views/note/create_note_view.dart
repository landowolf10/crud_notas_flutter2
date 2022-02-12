import 'package:crud_notas/views/widgets/textInput.dart';
import 'package:flutter/material.dart';

class CreateNoteView extends StatefulWidget {
  const CreateNoteView({ Key key }) : super(key: key);

  @override
  _CreateNoteViewState createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
  TextEditingController txtTitle = new TextEditingController();
  TextEditingController txtContent = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create your note"),
      ),
      body: Center(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 180),
                TextInput(hintText: "Title", txtController: txtTitle, inputType: TextInputType.text),
                SizedBox(height: 50),
                TextInput(hintText: "Content", txtController: txtContent, inputType: TextInputType.multiline),
              ],
            )
          ],
        ),
      ),
    );
  }
}