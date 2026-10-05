import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/theme_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state == ThemeMode.dark;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
          'Settings', 
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface, 
            fontWeight: FontWeight.w900,
            fontSize: 24,
          )
        ),
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onSurface),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSectionHeader(context, 'Preferences'),
          _buildSettingItem(context, Icons.notifications_active_outlined, 'Notifications', 'On'),
          _buildSettingItem(context, Icons.language_outlined, 'Language', 'English'),
          _buildThemeToggle(context, isDark),
          const SizedBox(height: 32),
          _buildSectionHeader(context, 'Account'),
          _buildSettingItem(context, Icons.security_outlined, 'Privacy & Security', ''),
          _buildSettingItem(context, Icons.help_outline, 'Help & Support', ''),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, IconData icon, String title, String trailing) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        title: Text(title, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (trailing.isNotEmpty) 
              Text(trailing, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios, color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.5), size: 16),
          ],
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildThemeToggle(BuildContext context, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(isDark ? Icons.dark_mode : Icons.light_mode, color: Theme.of(context).colorScheme.primary),
        ),
        title: Text('Dark Mode', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600)),
        trailing: Switch(
          value: isDark,
          activeColor: Theme.of(context).colorScheme.primary,
          onChanged: (_) {
            context.read<ThemeCubit>().toggleTheme();
          },
        ),
      ),
    );
  }
}
