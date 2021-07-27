import 'dart:math';

import 'package:crud_notas/src/api/notes_api.dart';
import 'package:crud_notas/src/models/notes_model.dart';
import 'package:crud_notas/src/views/login_page.dart';
import 'package:crud_notas/src/utils/messages.dart';
import 'package:flutter/material.dart';

class NotesList extends StatefulWidget
{
  @override
  NotesListState createState() => new NotesListState();
}

class NotesListState extends State<NotesList>
{
  NotesAPIs apis = new NotesAPIs();
  GetLoginData loginData = new GetLoginData();

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Created notes"),
      ),
      body: Center(
        child: notesList()
      )
    );
  }

  Widget notesList()
  {
    return ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            notesContainer()
          ],
        ),
        SizedBox(height: 50),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            addNoteBtn()
          ],
        )
      ],
    );
  }

  Widget notesContainer()
  {
    return SizedBox(
      height: 500,
      child: FutureBuilder<List<NotesModel>>(
        future: apis.getNotes(loginData.userID()),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
          {
            return Text(
              'No notes were found',
              style: TextStyle(
                fontSize: 50, 
                color: Colors.red
              ),
            );
          }

          List<NotesModel> values = snapshot.data;

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return cardView(values, index);
            }
          );
        },
      ),
    );
  }

  Widget cardView(List<NotesModel> values, int index)
  {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          noteListTile(values, index),
          noteDateCreation(values, index),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              updateTxtBtn(values, index),
              const SizedBox(width: 8),
              deleteTxtBtn(values, index)
              //const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }

  Widget addNoteBtn()
  {
    return ElevatedButton(
      child: Text('Add your note'),
      style: ElevatedButton.styleFrom(
          primary: Colors.red,
          onPrimary: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          textStyle: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          shadowColor: Colors.orange,
          elevation: 5),
      onPressed: () {
        createAndUpdateNoteDialog(context, 'create');
      },
    );
  }

  Widget noteListTile(List<NotesModel> values, int index)
  {
    return ListTile(
      leading: Icon(Icons.album),
      title: Text(
        values[index].titulo,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        values[index].contenido,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget noteDateCreation(List<NotesModel> values, int index)
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          'Created date: ' + values[index].fecha +
          ' - ' + values[index].hora,
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }

  Widget updateTxtBtn(List<NotesModel> values, int index)
  {
    return TextButton(
      child: Text(
        'UPDATE',
        style: TextStyle(
          color: Colors.white
        ),
      ),
      onPressed: () {
        int noteID;
        String noteTitle, noteContent;

        setState(() {
          noteID = values[index].idNota;
          noteTitle = values[index].titulo;
          noteContent = values[index].contenido;
          createAndUpdateNoteDialog(context, 'update', noteID: noteID, titulo: noteTitle, contenido: noteContent);
        });
      },
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

        await apis.deleteNote(noteID);
      },
    );
  }

  createAndUpdateNoteDialog(BuildContext context, String task, {int noteID, String titulo, String contenido}) async
  {
    TextEditingController _txtTitle = new TextEditingController();
    TextEditingController _txtContent = new TextEditingController();
    String buttonText = "";
    String dialogTitle = "";

    switch(task)
    {
      case 'create':
        _txtTitle.text = '';
        _txtContent.text = '';
        buttonText = 'Create note';
        dialogTitle = 'Create note';
        break;
      case 'update':
        _txtTitle.text = titulo;
        _txtContent.text = contenido;
        buttonText = 'Update note';
        dialogTitle = 'Update note';
        break;
    }

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(dialogTitle),
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
                  maxLines: null,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(buttonText),
              onPressed: () async {
                GetLoginData loginData;
                NotesAPIs notes;
                int _userID;

                setState(() {
                  loginData = new GetLoginData();
                  notes = new NotesAPIs();
                  _userID = loginData.userID();
                });
                
                switch(task)
                {
                  case 'create': await notes.createNotes(_userID, _txtTitle.text, _txtContent.text);
                                 break;
                  case 'update':
                    if (_txtTitle.text.isNotEmpty || _txtContent.text.isNotEmpty)
                    {
                      await notes.updateNote(noteID, _txtTitle.text, _txtContent.text);
                    }
                    else
                    {
                      Dialogs msg = new Dialogs();
                      msg.emptyBoxesDialog(context);
                    }
                    break;
                }

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
        );
      }
    );
  }
}