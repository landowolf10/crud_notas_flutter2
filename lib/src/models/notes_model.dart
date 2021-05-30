class NotesModel
{
  String nombreCreador;
  String fecha;
  String hora;
  String titulo;
  String contenido;

  NotesModel({
    this.nombreCreador,
    this.fecha,
    this.hora,
    this.titulo,
    this.contenido
  });

  factory NotesModel.fromJson(Map<String, dynamic> json)
  {
    return NotesModel(
      nombreCreador: json['nombre_creador'],
      fecha: json['fecha'],
      hora: json['hora'],
      titulo: json['titulo'],
      contenido: json['contenido']
    );
  }
}