import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:figme_task_app/models/album.dart';
import 'package:figme_task_app/resources/repositories/album_repository.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository albumRepository;
  late AlbumList allAlbums;
  late List<Album> userAlbums;
  AlbumBloc({required this.albumRepository}) : super(AlbumLoadingState());

  @override
  Stream<AlbumState> mapEventToState(
    AlbumEvent event,
  ) async* {
    if (event is AlbumLoadeEvent) {
      yield AlbumLoadingState();
      try {
        allAlbums = await albumRepository.fetchAllAlbums(event.userID);
        yield AlbumLoadedState(allAlbums: allAlbums);
      } on SocketException {
        yield AlbumErrorState(
          error: ('No Internet'),
        );
      } on HttpException {
        yield AlbumErrorState(
          error: ('No Service'),
        );
      } on FormatException {
        yield AlbumErrorState(
          error: ('No Formate Exception'),
        );
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
