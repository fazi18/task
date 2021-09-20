class AlbumList {
  final List<Album> albumList;

  AlbumList({required this.albumList});

  factory AlbumList.fromJson(List<dynamic> parsedJson) {
    final albums = parsedJson.map((a) => Album.fromJson(a)).toList();
    return AlbumList(albumList: albums);
  }
}

class Album {
  Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  String userId;
  String id;
  String title;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        userId: json["userId"].toString(),
        id: json["id"].toString(),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
      };
}
