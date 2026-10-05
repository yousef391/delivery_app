import 'auth_repo.dart';
import '../models/user_model.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<UserModel> login({required String phone, required String password}) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    if (phone == '0555555555' && password == 'password') {
      return const UserModel(
        id: '1',
        phone: '0555555555',
        name: 'Wahran User',
      );
    } else {
      throw Exception('Invalid credentials');
    }
  }
}
