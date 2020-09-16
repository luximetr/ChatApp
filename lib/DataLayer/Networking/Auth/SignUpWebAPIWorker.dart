
import 'package:chat_app/DataLayer/Networking/Base/FirebaseWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class SignUpWebAPIWorker extends FirebaseWebAPIWorker {

  CollectionReference _collectionReference;

  SignUpWebAPIWorker() {
    _collectionReference = firestore.collection('users');
  }

  Future<User> signUp({@required String name, @required String login, @required String password}) async {
    try {
      await _collectionReference.where('login', isEqualTo: login).get();
      throw Exception('User with this login already exist');
    } catch (exception) {
      if (exception.message != 'No element') {
        throw exception;
      }
      final newDoc = _collectionReference.doc();
      final id = newDoc.id;
      await newDoc.set({
        'id': newDoc.id,
        'name': name,
        'login': login,
        'password': password
      });
      return User(id: id, name: name);
    }
  }
}