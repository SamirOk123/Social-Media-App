class Story {
  final String username;
  final String uid;
  final String storyId;
  final String profImage;
  final String storyUrl;
  final DateTime datePublished;

  Story(
      {required this.datePublished,
      required this.profImage,
      required this.storyId,
      required this.storyUrl,
      required this.uid,
      required this.username});

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'storyId': storyId,
        'profImage': profImage,
        'storyUrl': storyUrl,
        'datePublished': datePublished,
      };

  // static Story fromSnap(DocumentSnapshot snap) {
  //   var snapshot = snap.data() as Map<String, dynamic>;
  //   return Story(
  //       datePublished: snapshot['datePublished'],
  //       storyId: snapshot['storyId'],
  //       storyUrl: snapshot['storyUrl'],
  //       profImage: snapshot['profImage'],
  //       uid: snapshot['uid'],
  //       username: snapshot['username']);
  // }
}
