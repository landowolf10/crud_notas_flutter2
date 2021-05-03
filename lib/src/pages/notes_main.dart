import 'package:crud_notas/src/api/notes_api.dart';
import 'package:crud_notas/src/pages/notes_list.dart';
import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  NotesAPIs apis = new NotesAPIs();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prueba"),
      ),
      body: Center(
        child: Container(
          child: ListView(
            children: <Widget>[
              ElevatedButton(
                  child: Text('Get all notes'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  onPressed: () {
                    print("Presionado");
                    Navigator.pushReplacement(
                      context, MaterialPageRoute(
                        builder: (BuildContext ctx) => NotesList()
                      )
                    );
                    
                    //apis.getNotes();
                    //apiAlbum.fetchUsers();
                  },
              ),
            ]
          ),
        )
      ),
    );



    /*return Container(
      child: ListView(
        children: <Widget>[
          ElevatedButton(
              child: Text('Get all notes'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                )
              ),
              onPressed: () {
                print("Presionado");
              },
            ),
        ]
      ),
    );*/
  }
}