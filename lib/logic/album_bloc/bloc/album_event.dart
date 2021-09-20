part of 'album_bloc.dart';

abstract class AlbumEvent extends Equatable {
  const AlbumEvent();

  @override
  List<Object> get props => [];
}

class AlbumLoadeEvent extends AlbumEvent {
  final String userID;
  AlbumLoadeEvent({required this.userID});
}
