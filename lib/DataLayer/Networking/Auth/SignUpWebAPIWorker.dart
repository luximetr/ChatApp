
import 'package:chat_app/DataLayer/Networking/Base/FirestoreWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/Exceptions/AlreadyExistException.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class SignUpWebAPIWorker extends FirestoreWebAPIWorker {

  CollectionReference _collectionReference;

  SignUpWebAPIWorker() {
    _collectionReference = firestore.collection('users');
  }

  Future<User> signUp({@required String name, @required String login, @required String password}) async {
    final document = await _collectionReference.where('login', isEqualTo: login).get();
    if (document.docs.isNotEmpty) {
      throw AlreadyExistException('This login already taken');
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