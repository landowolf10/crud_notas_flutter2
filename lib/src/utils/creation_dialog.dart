import 'package:crud_notas/src/api/notes_api.dart';
import 'package:crud_notas/src/views/login_page.dart';
import 'package:flutter/material.dart';

/*class NoteCreationPage extends StatefulWidget {

  @override
  _NoteCreationPageState createState() => _NoteCreationPageState();
}

class _NoteCreationPageState extends State<NoteCreationPage> {
  TextEditingController _txtTitle = new TextEditingController();
  TextEditingController _txtContent = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    
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
                  GetLoginData loginData;
                  NotesAPIs notes;
                  int _userID;

                  setState(() {
                    loginData = new GetLoginData();
                    notes = new NotesAPIs();
                    _userID = loginData.userID();
                  });

                  await notes.createNotes(_userID, _txtTitle.text, _txtContent.text);
                    Navigator.of(context).pop();

                  //print(notesList.length);
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
  }
}*/

class CreateUserDialog
{
  TextEditingController _txtTitle = new TextEditingController();
  TextEditingController _txtContent = new TextEditingController();
  NotesAPIs notes = new NotesAPIs();

  createUserDialog(BuildContext context) async {
    _txtTitle.text = '';
    _txtContent.text = '';

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, setState) {
              return Container(
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
                      TextButton(
                        child: Text('Create note'),
                        onPressed: () async {
                          GetLoginData loginData;
                          NotesAPIs notes;
                          int _userID;

                          setState(() {
                            loginData = new GetLoginData();
                            notes = new NotesAPIs();
                            _userID = loginData.userID();
                          });

                          await notes.createNotes(_userID, _txtTitle.text, _txtContent.text);
                            Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                );
              },
            ),
            title: Text('Create new note'),
            
            //actions: 
          );
        });
  }
}
  