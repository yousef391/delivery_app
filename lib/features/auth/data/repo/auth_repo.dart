import '../models/user_model.dart';

abstract interface class AuthRepo {
  Future<UserModel> login({required String phone, required String password});
}
