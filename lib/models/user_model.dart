class User {
  final String userName;
  final String bio;
  final String dateOfBirth;
  final String location;

  User(
      {required this.bio,
      required this.dateOfBirth,
      required this.userName,
      required this.location});

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'bio': bio,
        'dateOfBirth': dateOfBirth,
        'location': location,
      };

 static User fromJson(Map<String, dynamic> json) => User(
      dateOfBirth: json['dateOfBirth'],
      userName: json['userName'],
      location: json['location'],
      bio: json['bio']);
}
