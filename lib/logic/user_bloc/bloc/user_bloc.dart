import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:figme_task_app/models/user.dart';
import 'package:figme_task_app/resources/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  late UserList _userList;
  UserBloc({required this.userRepository}) : super(UserLoadingState());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is FatchUserEvent) {
      yield UserLoadingState();
      try {
        _userList = await userRepository.fatchAllUser();
        yield UserLoadedState(users: _userList);
      } on SocketException {
        yield UserListErrorstate(
          error: ('No Internet'),
        );
      } on HttpException {
        yield UserListErrorstate(
          error: ('No Service'),
        );
      } on FormatException {
        yield UserListErrorstate(
          error: ('No Formate Exception'),
        );
      } catch (e) {
        print(e.toString());
      }
    } else if (event is SearchUserEvent) {
      yield UserLoadingState();
      try {
        yield UserSearchState(users: event.users);
      } catch (e) {
        print(e.toString());
      }
    } else if (event is BackUserLoadedEvent) {
      yield UserLoadingState();
      try {
        yield UserLoadedState(users: _userList);
      } catch (e) {
        print(e.toString());
      }
    } else if (event is EmptyUserListEvent) {
      String message = 'Search Result Not Found';
      yield UserEmptyListState(message: message);
    } else if (event is UserGenderFilterEvent) {
      yield UserLoadingState();
      try {
        final users = _userList.userList.where((user) {
          String valueLower = event.userFilterValue!.toLowerCase();
          if (valueLower == 'men') valueLower = 'man';
          return user.getGender().contains(valueLower);
        }).toList();
        yield UserFilterState(
            filteredUsers: users, filterValue: event.userFilterValue);
      } catch (e) {
        print(e);
      }
    } else if (event is AllUserFilterEvent) {
      yield UserLoadingState();
      try {
        yield UserLoadedState(users: _userList);
      } catch (e) {
        print(e);
      }
    }
  }
}
