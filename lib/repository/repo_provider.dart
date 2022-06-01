import 'package:flutter_assignment/models/userList.dart';
import 'package:flutter_assignment/networking/api_provider.dart';

class RepoProvider {
  final ApiProvider _provider = ApiProvider();
  Future<UserList> userList() async {
    final response = await _provider.userList();
    return UserList.fromJson(response);
  }
}