
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection.dart';
import 'core/theme/theme_cubit.dart';
import 'features/onboarding/presentation/screens/onboarding_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDI();
  runApp(const OranDeliveryApp());
}

class OranDeliveryApp extends StatelessWidget {
  const OranDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Oran Delivery',
            themeMode: themeMode,
            theme: ThemeData(
              brightness: Brightness.light,
              scaffoldBackgroundColor: const Color(0xFFF5F5F5),
              cardColor: Colors.white,
              colorScheme: const ColorScheme.light(
                primary: Color(0xFF1E88E5), // Blue accent for light mode
                surface: Color(0xFFF5F5F5),
                surfaceContainer: Colors.white,
                surfaceContainerHighest: Color(0xFFE0E0E0),
                onSurface: Colors.black87,
                onSurfaceVariant: Colors.black54,
              ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: const Color(0xFF121212),
              cardColor: const Color(0xFF1C1C1E),
              colorScheme: const ColorScheme.dark(
                primary: Color(0xFFD4FF26), // Neon Yellow for dark mode
                surface: Color(0xFF121212),
                surfaceContainer: Color(0xFF1C1C1E),
                surfaceContainerHighest: Color(0xFF2C2C2E),
                onSurface: Colors.white,
                onSurfaceVariant: Color(0xFFA0A0A5),
              ),
              useMaterial3: true,
            ),
            home: const OnboardingScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
