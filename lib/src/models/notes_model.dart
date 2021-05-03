class NotesModel
{
  String name;
  String mail;
  String password;

  NotesModel({
    this.name,
    this.mail,
    this.password
  });

  factory NotesModel.fromJson(Map<String, dynamic> json)
  {
    return NotesModel(
      name: json['nombre'],
      mail: json['correo'],
      password: json['pass']
    );
  }
}