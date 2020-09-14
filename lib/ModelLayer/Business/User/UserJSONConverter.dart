
import 'User.dart';

class UserJSONConverter {

  User toUser(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final name = json['name'] as String;
    if (id is! String || id.isEmpty) { throw Exception('Unable to parse User, json should have an ID'); }

    return User(
        id: id,
        name: name ?? ''
    );
  }
}