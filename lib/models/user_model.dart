import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userName;
  final String bio;
  final String location;
  final List followers;
  final List following;
  final String uid;
  final String photoUrl;

  User(
      {required this.bio,
      required this.uid,
      required this.followers,
      required this.following,
      required this.photoUrl,
      required this.userName,
      required this.location});

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'bio': bio,
        'location': location,
        'photoUrl': photoUrl,
        'followers': followers,
        'following': following,
        'uid': uid,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        userName: snapshot['userName'],
        location: snapshot['location'],
        bio: snapshot['bio'],
        uid: snapshot['uid'],
        followers: snapshot['followers'],
        following: snapshot['following'],
        photoUrl: snapshot['photoUrl']);
  }
}
