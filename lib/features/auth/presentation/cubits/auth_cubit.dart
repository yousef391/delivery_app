import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import '../../data/repo/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;

  AuthCubit({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(const AuthInitial());

  Future<void> login({
    required String phone,
    required String password,
  }) async {
    emit(const AuthLoading());
    try {
      final user = await _authRepo.login(phone: phone, password: password);
      emit(AuthSuccess(user: user));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }
}
