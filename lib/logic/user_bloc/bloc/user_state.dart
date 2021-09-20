part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserLoadingState extends UserState {}

class UserInitialState extends UserState {}

class UserLoadedState extends UserState {
  final UserList users;
  UserLoadedState({required this.users});
}

class UserSearchState extends UserState {
  final List<User> users;
  UserSearchState({required this.users});
}

class UserListErrorstate extends UserState {
  final error;
  UserListErrorstate({this.error});
}

class BackUserLoadedState extends UserState {
  final List<User> users;
  BackUserLoadedState({required this.users});
}

class UserEmptyListState extends UserState {
  final String message;
  UserEmptyListState({required this.message});
}

class UserFilterState extends UserState {
  final String? filterValue;
  final List<User> filteredUsers;
  UserFilterState({required this.filteredUsers, required this.filterValue});
}
