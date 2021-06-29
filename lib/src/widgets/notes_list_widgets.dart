import 'package:crud_notas/src/models/notes_model.dart';
import 'package:flutter/material.dart';

class NotesWidgets extends StatefulWidget {

  @override
  NotesWidgetsState createState() => NotesWidgetsState();
}

class NotesWidgetsState extends State<NotesWidgets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }

  Widget deleteTxtBtn(List<NotesModel> values, int index)
  {
    return TextButton(
      child: const Text(
        'DELETE',
        style: TextStyle(
          color: Colors.white
        ),
      ),
      onPressed: () async {
        int noteID;

        setState(() {
          noteID = values[index].idNota;
        });

        //await apis.deleteNote(noteID);
      },
    );
  }
}