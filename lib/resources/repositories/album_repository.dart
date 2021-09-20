import 'package:figme_task_app/models/album.dart';
import 'package:figme_task_app/resources/providers/album_provider.dart';

class AlbumRepository {
  final AlbumProvider albumProvider = AlbumProvider();

  Future<AlbumList> fetchAllAlbums(String userID) =>
      albumProvider.fetchAlbumDate(userID);
}
