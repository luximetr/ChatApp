
import 'package:chat_app/DataLayer/Networking/Base/FirestoreWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:chat_app/ModelLayer/Business/User/UserJSONConverter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FindUserWebAPIWorker extends FirestoreWebAPIWorker {

  CollectionReference _collectionReference;
  UserJSONConverter _userJSONConverter;

  FindUserWebAPIWorker() {
    _collectionReference = firestore.collection('users');
    _userJSONConverter = UserJSONConverter();
  }

  Future<User> findUser(String login) {
    return _collectionReference
        .where('login', isEqualTo: login)
        .get()
        .then((snapshot) {
          final json = snapshot.docs.first.data();
          return _userJSONConverter.toUser(json);
        });
  }
}