import 'dart:convert';

class NotesModel
{
  int idNota;
  int idUsuario;
  String nombreCreador;
  String fecha;
  String hora;
  String titulo;
  String contenido;

  NotesModel({
    this.idNota,
    this.idUsuario,
    this.nombreCreador,
    this.fecha,
    this.hora,
    this.titulo,
    this.contenido
  });

  factory NotesModel.fromJson(Map<dynamic, dynamic> json)
  {
    return NotesModel(
      idNota: json['id'],
      idUsuario: json['id_usuario'],
      nombreCreador: json['nombre_creador'],
      fecha: json['fecha'],
      hora: json['hora'],
      titulo: json['titulo'],
      contenido: json['contenido']
    );
  }

  Map<String, dynamic> toJson()
  {
    return {
      'id': idNota,
      'id_usuario': idUsuario,
      'nombre_creador': nombreCreador,
      'fecha': fecha,
      'hora': hora,
      'titulo': titulo,
      'contenido': contenido,
    };
  }

  String notesToJson(NotesModel data)
  {
    final jsonData = data.toJson();
    return json.encode(jsonData);
  }
}