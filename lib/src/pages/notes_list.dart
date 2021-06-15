import 'package:crud_notas/src/api/notes_api.dart';
import 'package:crud_notas/src/models/notes_model.dart';
import 'package:crud_notas/src/pages/login_page.dart';
import 'package:flutter/material.dart';

class NotesList extends StatefulWidget {
  @override
  NotesListState createState() => new NotesListState();
}

class NotesListState extends State<NotesList> {
  NotesAPIs apis = new NotesAPIs();
  GetLoginData loginData = new GetLoginData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Created notes"),
      ),
      body: Center(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 400,
                  child: FutureBuilder<List<NotesModel>>(
                    future: apis.getNotes(loginData.userID()),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                      {
                        return Text('No notes were found',
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.red
                          ),
                        );
                      }
                        
                      var values = snapshot.data;

                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.album),
                                  title: Text(values[index].titulo),
                                  subtitle: Text(values[index].contenido),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text('Created date: ' + values[index].fecha + ' - ' + values[index].hora)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    TextButton(
                                      child: const Text('UPDATE'),
                                      onPressed: () {
                                        print('Note updated');
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    TextButton(
                                      child: const Text('DELETE'),
                                      onPressed: () async {
                                        int noteID = values[index].idNota;

                                        print(noteID);

                                        await apis.deleteNote(noteID);
                                      },
                                    ),
                                    //const SizedBox(width: 8),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text('Create note'),
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
                  onPressed: () {
                    //CreateUserDialog createUser = CreateUserDialog();

                    //createUser.createUserDialog(context);
                    createUserDialog(context);
                  },
                )
              ],
            )
          ],
        )
      )
    );
  }

  TextEditingController _txtTitle = new TextEditingController();
  TextEditingController _txtContent = new TextEditingController();

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
                  NotesAPIs notes = new NotesAPIs();
                  int _userID = loginData.userID();

                  setState(() {
                    
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
        });
  }
}
