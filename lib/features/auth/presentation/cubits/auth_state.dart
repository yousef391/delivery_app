import 'package:equatable/equatable.dart';
import '../../data/models/user_model.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthSuccess extends AuthState {
  final UserModel user;
  const AuthSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

final class AuthFailure extends AuthState {
  final String message;
  const AuthFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
