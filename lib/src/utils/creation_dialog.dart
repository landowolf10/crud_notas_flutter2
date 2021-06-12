import 'package:crud_notas/src/api/notes_api.dart';
import 'package:crud_notas/src/pages/login_page.dart';
import 'package:flutter/material.dart';

class CreateUserDialog
{
  TextEditingController _txtTitle = new TextEditingController();
  TextEditingController _txtContent = new TextEditingController();
  NotesAPIs notes = new NotesAPIs();
  List<Map<String, dynamic>> notesList = [];

  createUserDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Create new note'),
            content: Container(
              width: 50,
              child: ListView(
                children: [
                  TextField(
                    controller: _txtTitle,
                    decoration: InputDecoration(hintText: "Enter note title"),
                  ),
                  TextField(
                    controller: _txtContent,
                    decoration: InputDecoration(hintText: "Write your note"),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Create note'),
                onPressed: () async {
                  

                  GetLoginData loginData = new GetLoginData();
                  int _userID = loginData.userID();

                  /*print(_userName);
                  print('Title: ' + _txtTitle.text);
                  print('Title: ' + _txtContent.text);*/

                  Map<String, dynamic> objNotes = {
                    "user_id": _userID,
                    "note_title": _txtTitle,
                    "note_content": _txtContent
                  };

                  notesList.add(objNotes);

                  await notes.createNotes(_userID, _txtTitle.text, _txtContent.text);
                  Navigator.of(context).pop();

                  print(notesList.length);
                },
              ),
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
  