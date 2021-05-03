import 'package:crud_notas/src/api/notes_api.dart';
import 'package:crud_notas/src/models/notes_model.dart';
import 'package:crud_notas/src/pages/notes_main.dart';
import 'package:flutter/material.dart';

class NotesList extends StatefulWidget {
  @override
  NotesListState createState() => new NotesListState();
}

class NotesListState extends State<NotesList> {
  NotesAPIs apis = new NotesAPIs();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Created notes"),
        ),
        body: Container(
            alignment: Alignment.center,
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 400,
                      child: FutureBuilder<List<NotesModel>>(
                        future: apis.getNotes(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return CircularProgressIndicator();

                          var values = snapshot.data;

                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(values[index].name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      )
                                    ),
                                );
                              });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  child: Text('Main menu'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  onPressed: () {
                    //print("Presionado");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Notes()),
                      );
                    
                    //apis.getNotes();
                    //apiAlbum.fetchUsers();
                  },
              ),
              ],
            )
        )
    );
  }
}
