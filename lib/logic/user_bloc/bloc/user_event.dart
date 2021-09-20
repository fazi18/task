part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FatchUserEvent extends UserEvent {}

class SearchUserEvent extends UserEvent {
  final List<User> users;
  SearchUserEvent({required this.users});
}

class BackUserLoadedEvent extends UserEvent {}

class EmptyUserListEvent extends UserEvent {}

class UserGenderFilterEvent extends UserEvent {
  final String? userFilterValue;
  UserGenderFilterEvent({required this.userFilterValue});
}

class AllUserFilterEvent extends UserEvent {}
