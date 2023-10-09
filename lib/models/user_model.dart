class UserModel {
  static const String COLLECTION_NAME = "Users";
  String id;
  String name;
  String birthday;
  String email;

  UserModel(
      {this.id = "",
      required this.name,
      required this.birthday,
      required this.email});

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            name: json['name'],
            birthday: json['birthday'],
            email: json['email']);

  Map<String, dynamic>toJson(){
    return {
      "id" : id,
      "name" : name,
      "birthday" : birthday,
      "email" : email,
    };
  }
}
