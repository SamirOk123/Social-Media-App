class Comment {
  final String uid;
  final String username;
  final String postId;
  final String comment;
  final String profPic;
  final DateTime datePublished;
  final List likes;
  final String commentId;

  Comment(
      {required this.comment,
      required this.likes,
      required this.commentId,
      required this.datePublished,
      required this.postId,
      required this.profPic,
      required this.uid,
      required this.username});

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'comment': comment,
        'postId': postId,
        'profPic': profPic,
        'datePublished': datePublished,
        'likes': likes,
        'commentId': commentId
      };
}
