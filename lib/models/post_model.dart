import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String username;
  final String uid;
  final String postId;
  final String profImage;
  final String postUrl;
  final likes;
  final datePublished;

  Post(
      {required this.datePublished,
      required this.description,
      required this.likes,
      required this.postId,
      required this.postUrl,
      required this.profImage,
      required this.uid,
      required this.username});

  Map<String, dynamic> toJson() => {
        'description': description,
        'username': username,
        'uid': uid,
        'postId': postId,
        'profImage': profImage,
        'postUrl': postUrl,
        'likes': likes,
        'datePublished': datePublished,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
        datePublished: snapshot['datePublished'],
        description: snapshot['description'],
        likes: snapshot['likes'],
        postId: snapshot['postId'],
        postUrl: snapshot['postUrl'],
        profImage: snapshot['profImage'],
        uid: snapshot['uid'],
        username: snapshot['username']);
  }
}
