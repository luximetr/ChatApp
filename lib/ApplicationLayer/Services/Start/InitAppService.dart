
import 'package:firebase_core/firebase_core.dart';

class InitAppService {

  initialize() async {
    await Firebase.initializeApp();
    return;
  }
}