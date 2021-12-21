// ignore_for_file: non_constant_identifier_names, file_names

//format (m['notes'][0][0]);
class UserData {
  final int id;
  final String name;
  final String image;
  //final Map<String media type, String file> content

  UserData(
    this.id,
    this.name,
    this.image,
  );

  UserData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = json['avatar_urls']['24'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
      };
}
