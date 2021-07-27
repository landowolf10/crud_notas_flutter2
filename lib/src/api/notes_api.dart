import 'package:crud_notas/src/models/notes_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NotesAPIs
{
  String url = 'http://192.168.0.19:3000/note';
  List<NotesModel> notesList;

  Future<List<NotesModel>> getNotes(int userID) async
  {
    final response = await http.get(Uri.parse(url + '/' + userID.toString()));

    if (response.statusCode == 200)
    {
      List data = json.decode(response.body);
      
      notesList = data.map<NotesModel>((json) {
        return NotesModel.fromJson(json);
      }).toList();
    }
    else
      throw Exception('Unable to fetch notes from the REST API');

    return notesList;
  }

  Future<NotesModel> createNotes(int idUsuario, String titulo, String contenido) async
  {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic> {
        'id_usuario': idUsuario,
        'titulo': titulo,
        'contenido': contenido
      })
    );

    print(response.body);
    
    if(response.statusCode == 200)
    {
      var createdNote = json.decode(response.body);

      return NotesModel.fromJson(createdNote);
    }
    else
    {
      print("Failed to create new note");
      throw Exception("Failed to create new note");
    }
  }

  Future<NotesModel> updateNote(int idNota, String titulo, String contenido) async
  {
    final response = await http.put(
      Uri.parse(url),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic> {
        'id': idNota,
        'titulo': titulo,
        'contenido': contenido
      })
    );

    print(response.body);
    
    if(response.statusCode == 200)
    {
      var updatedNote = json.decode(response.body);

      return NotesModel.fromJson(updatedNote);
    }
    else
    {
      print("Failed to update the selected note");
      throw Exception("Failed to update the selected note");
    }
  }

  Future<NotesModel> deleteNote(int idNota) async
  {
    final response = await http.delete(
      Uri.parse(url + '/$idNota'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    
    if(response.statusCode == 200)
    {
      var deletedNote = json.decode(response.body);

      return NotesModel.fromJson(deletedNote);
    }
    else
    {
      print("Failed to delete the selected note");
      throw Exception("Failed to delete the selected note");
    }
  }
}