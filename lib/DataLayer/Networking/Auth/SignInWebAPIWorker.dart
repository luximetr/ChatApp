
import 'package:chat_app/DataLayer/Networking/Base/FirebaseWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:chat_app/ModelLayer/Business/User/UserJSONConverter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class SignInWebAPIWorker extends FirebaseWebAPIWorker {

  CollectionReference _collectionReference;
  UserJSONConverter _userJSONConverter;

  SignInWebAPIWorker() {
    _collectionReference = firestore.collection('users');
    _userJSONConverter = UserJSONConverter();
  }

  Future<User> signIn({@required String login, @required String password}) async {
    return _collectionReference
        .where('login', isEqualTo: login)
        .where('password', isEqualTo: password)
        .get()
        .then((value) {
          final json = value.docs.first.data();
          return _userJSONConverter.toUser(json);
        });
  }
}