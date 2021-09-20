import 'package:figme_task_app/models/post.dart';
import 'package:figme_task_app/resources/providers/post_provider.dart';

class PostRepository {
  final PostProvider postProvider = PostProvider();

  Future<PostList> fetchAllPosts(String userID) =>
      postProvider.fetchPostData(userID);

  Future<List<Post>> setPost(String id, String title, String body) =>
      postProvider.setPostData(id, title, body);

  List<Post> putPost(String id, String title, String body, int index) =>
      postProvider.putPostData(id, title, body, index);

  List<Post> deletePost(String id) => postProvider.deletePostData(id);
}
