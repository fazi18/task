part of 'album_bloc.dart';

abstract class AlbumState extends Equatable {
  const AlbumState();

  @override
  List<Object> get props => [];
}

class AlbumLoadingState extends AlbumState {}

class AlbumLoadedState extends AlbumState {
  final AlbumList allAlbums;
  AlbumLoadedState({required this.allAlbums});
}

class AlbumErrorState extends AlbumState {
  final error;
  AlbumErrorState({this.error});
}
