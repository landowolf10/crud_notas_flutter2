class UserModel
{
  final String name;
  final String mail;
  final String password;

  UserModel({
    this.name,
    this.mail,
    this.password
  });

  factory UserModel.fromJson(Map<String, dynamic> json)
  {
    return UserModel(
      name: json['nombre'],
      mail: json['correo'],
      password: json['pass']
    );
  }
}