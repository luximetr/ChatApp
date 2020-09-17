
import 'package:chat_app/DataLayer/Networking/User/FindUserWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';

class FindUserService {

  final _findUserWebAPIWorker = FindUserWebAPIWorker();

  Future<User> findUser(String login) {
    return _findUserWebAPIWorker.findUser(login);
  }
}