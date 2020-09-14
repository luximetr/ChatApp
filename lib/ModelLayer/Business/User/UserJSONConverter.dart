
import 'User.dart';

class UserJSONConverter {

  User toUser(Map<String, dynamic> json) {
    if (json == null) { return null; }
    final id = json['id'] as String;
    final name = json['name'] as String;
    if (id is! String || id.isEmpty) { throw Exception('Unable to parse User, json should have an ID'); }

    return User(
        id: id,
        name: name ?? ''
    );
  }

  Map<String, dynamic> toJSON(User user) {
    return {
      'id': user.id,
      'name': user.name
    };
  }
}