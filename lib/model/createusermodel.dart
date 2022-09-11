class CreateUserModel {
  String id;
  String name;
  String password;
  String dateOfBirth;
  CreateUserModel(
      {this.id = '',
      required this.name,
      required this.password,
      required this.dateOfBirth});
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'password': password,
        'dateOfBirth': dateOfBirth
      };
}
