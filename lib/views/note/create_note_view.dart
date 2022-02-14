import 'package:crud_notas/api/notes_api.dart';
import 'package:crud_notas/models/notes_model.dart';
import 'package:crud_notas/utils/messages.dart';
import 'package:crud_notas/views/user/login_page.dart';
import 'package:crud_notas/views/widgets/textInput.dart';
import 'package:flutter/material.dart';

class CreateNoteView extends StatefulWidget {
  const CreateNoteView({ Key key }) : super(key: key);

  @override
  _CreateNoteViewState createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
  TextEditingController _txtTitle = new TextEditingController();
  TextEditingController _txtContent = new TextEditingController();

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
                TextInput(hintText: "Title", txtController: _txtTitle, inputType: TextInputType.text),
                SizedBox(height: 50),
                TextInput(hintText: "Content", txtController: _txtContent, inputType: TextInputType.multiline, maxLines: 5),
                SizedBox(height: 50),
                _commonButton()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _commonButton()
  {
    return ElevatedButton(
      child: Text('Create note'),
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
        GetLoginData loginData;
        NotesAPIs notes;
        int _userID;

        setState(() {
          loginData = new GetLoginData();
          notes = new NotesAPIs();
          _userID = loginData.userID();
        });

        if(_txtTitle.text.isEmpty || _txtContent.text.isEmpty)
        {
          Dialogs().emptyBoxesDialog(context);
          return;
        }

        NotesModel notesData = NotesModel(idUsuario: _userID, titulo: _txtTitle.text, contenido: _txtContent.text);

        await notes.createNotes(notesData);
      }
    );
  }
}