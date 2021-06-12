import 'package:crud_notas/src/models/notes_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NotesAPIs
{
  String url = 'http://192.168.0.15:3000/notes';
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

  Future<NotesModel> createNotes(int idCreador, String titulo, String contenido) async
  {
    print('Recibiendo: ' + idCreador.toString() + ' - ' + titulo + ' - ' + contenido);

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic> {
        'id_creador': idCreador,
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
}