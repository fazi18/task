import 'dart:convert';

import 'package:figme_task_app/models/user.dart';
import 'package:http/http.dart';

class UserProvider {
  Client client = Client();

  Future<UserList> fetchUserDate() async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/users");
    final response = await client.get(url);
    print(response.body.toString());
    if (response.statusCode == 200) {
      final UserList userList = UserList.fromJson(json.decode(response.body));
      for (User user in userList.userList) {
        if (user.id == '2' || user.id == '8' || user.id == '10') {
          user.setGender('man');
        } else {
          user.setGender('women');
        }
      }
      return userList;
    } else {
      // TODO: if Network not make connection.
      // return null as Future<User>;
      throw Exception('faield to load');
    }
  }
}

//!woman 1, 3, 4,5, 6,7,9
