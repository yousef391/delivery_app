import 'package:get_it/get_it.dart';
import '../../features/auth/data/repo/auth_repo.dart';
import '../../features/auth/data/repo/auth_repo_impl.dart';
import '../../features/auth/presentation/cubits/auth_cubit.dart';

final getIt = GetIt.instance;

void setupDI() {
  // Repos
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(),
  );

  // Cubits — register as Factory so each screen gets a fresh instance
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(authRepo: getIt<AuthRepo>()),
  );
}
