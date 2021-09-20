import 'dart:convert';

import 'package:figme_task_app/models/post.dart';
import 'package:http/http.dart' as http;

class PostProvider {
  http.Client client = http.Client();
  List<Post> posts = [];
  Future<PostList> fetchPostData(String userID) async {
    print('----------$userID----------');
    final url =
        Uri.parse("https://jsonplaceholder.typicode.com/users/$userID/posts");
    print('----------${url.toString()}----------');
    final response = await client.get(url);
    print(response.body.toString());
    if (response.statusCode == 200) {
      return PostList.fromJson(json.decode(response.body));
    } else {
      // TODO: if Network not make connection.
      throw Exception('Failed to load posts');
    }
  }

  Future<List<Post>> setPostData(String id, String title, String body) async {
    var response = await http
        .post(Uri.parse("https://jsonplaceholder.typicode.com/posts"), body: {
      "id": id,
      'title': title,
      'body': body,
    });
    Post postModel = Post.fromJson(json.decode(response.body));
    Post myPost = Post(
        userId: '11', id: id, title: postModel.title, body: postModel.body);
    posts.add(myPost);
    return posts;
  }

  List<Post> putPostData(String id, String title, String body, int index) {
    posts[index].id = id;
    posts[index].title = title;
    posts[index].body = body;
    return posts;
  }

  List<Post> deletePostData(String id) {
    posts.removeWhere((post) => post.id == id);
    return posts;
  }
}
