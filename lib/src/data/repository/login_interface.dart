import 'package:rha/src/domain/domain.dart';

abstract class LoginInterface {
  Future<ResponseModel> login({required LoginDto loginDto});
}
