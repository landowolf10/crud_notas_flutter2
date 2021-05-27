import 'package:crud_notas/src/api/notes_api.dart';
import 'package:crud_notas/src/models/notes_model.dart';
//import 'package:crud_notas/src/pages/notes_main.dart';
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
          children: [
            Column(
              children: [
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
                        }
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            ElevatedButton(
            child: Text('Iniciar sesión'),
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
              print('Note created');
            },
          )
            /*ElevatedButton(
              child: Text('Main menu'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                textStyle: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                )
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Notes()),
                  );
                    
                //apis.getNotes();
                //apiAlbum.fetchUsers();
              },
            ),*/
          ],
        )
      )
    );
  }
}
