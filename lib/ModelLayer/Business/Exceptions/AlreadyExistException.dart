
import 'package:chat_app/ModelLayer/Business/Exceptions/BaseException.dart';

class AlreadyExistException extends BaseException {

  AlreadyExistException(String message) : super(message);
}