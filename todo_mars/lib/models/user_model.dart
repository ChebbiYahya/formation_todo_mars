import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  String? nom;
  String? email;
  String? password;

  UserModel({this.nom, this.email, this.password});

  Map<String, dynamic> toJson() {
    return {"nom": nom, "email": email, "password": password};
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json["email"],
    nom: json["nom"],
    password: json["password"],
  );
}
