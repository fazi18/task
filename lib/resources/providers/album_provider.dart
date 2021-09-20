import 'dart:convert';

import 'package:figme_task_app/models/album.dart';
import 'package:http/http.dart';

class AlbumProvider {
  Client client = Client();

  Future<AlbumList> fetchAlbumDate(String userID) async {
    print('enternd');
    final url =
        Uri.parse("https://jsonplaceholder.typicode.com/users/$userID/albums");
    final response = await client.get(url);
    print('enternd');
    if (response.statusCode == 200) {
      print('------enternd in status cod-------');
      AlbumList albumList = AlbumList.fromJson(json.decode(response.body));
      print(albumList.albumList[0].title.toString());
      return albumList;
    } else {
      // TODO: if Network not make connection.
      throw Exception('Failed to load albums');
    }
  }
}
