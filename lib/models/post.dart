class PostList {
  final List<Post> postList;

  PostList({required this.postList});

  factory PostList.fromJson(List<dynamic> parsedJson) {
    final posts = parsedJson.map((p) => Post.fromJson(p)).toList();
    return PostList(postList: posts);
  }
}

class Post {
  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  String userId;
  String id;
  String title;
  String body;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json["userId"].toString(),
        id: json["id"].toString(),
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
