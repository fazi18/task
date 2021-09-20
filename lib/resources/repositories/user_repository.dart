import 'package:figme_task_app/models/user.dart';
import 'package:figme_task_app/resources/providers/user_provider.dart';

class UserRepository {
  final UserProvider userProvider = UserProvider();

  Future<UserList> fatchAllUser() => userProvider.fetchUserDate();
}
