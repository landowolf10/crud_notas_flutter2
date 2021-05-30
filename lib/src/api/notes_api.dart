import 'package:crud_notas/src/models/notes_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NotesAPIs
{
  String url = '192.168.0.5:3000';
  List<NotesModel> notesList;

  Future<List<NotesModel>> getNotes() async
  {
    final response = await http.get(Uri.http(url, '/get_notes'));

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
}