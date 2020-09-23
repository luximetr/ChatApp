
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreWebAPIWorker {

  FirebaseFirestore firestore;

  FirestoreWebAPIWorker() {
    firestore = FirebaseFirestore.instance;
    firestore.settings = Settings(persistenceEnabled: false);
  }
}