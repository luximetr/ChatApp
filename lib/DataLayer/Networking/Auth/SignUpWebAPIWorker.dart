
import 'package:chat_app/DataLayer/Networking/Base/FirebaseWebAPIWorker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class SignUpWebAPIWorker extends FirebaseWebAPIWorker {

  CollectionReference _collectionReference;

  SignUpWebAPIWorker() {
    _collectionReference = firestore.collection('users');
  }

  Future<void> signUp({@required String login, @required String password}) async {
    try {
      final snapshot = await _collectionReference.where('login', isEqualTo: login).get();
      if (snapshot.docs.first.exists) {
        return Future.error(Exception('User with this login already exist'));
      }
    } catch (exception) {
      if (exception.message != 'No element') {
        throw exception;
      }
      final newDoc = _collectionReference.doc();
      return newDoc.set({
        'id': newDoc.id,
        'login': login,
        'password': password
      });
    }
  }
}