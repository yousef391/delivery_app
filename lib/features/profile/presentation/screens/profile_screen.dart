import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
          'My Profile', 
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface, 
            fontWeight: FontWeight.w900,
            fontSize: 24,
          )
        ),
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onSurface),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Theme.of(context).colorScheme.primary, width: 3),
                ),
                child: const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/avatar.jpg'),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Wahran User',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              '+213 555 55 55 55',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 16),
            ),
            const SizedBox(height: 40),
            _buildProfileStat(context, 'Total Deliveries', '142', Icons.inventory_2_outlined),
            _buildProfileStat(context, 'Rating', '4.9', Icons.star_outline),
            _buildProfileStat(context, 'Member Since', 'Oct 2023', Icons.calendar_today_outlined),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStat(BuildContext context, String title, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 28),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 14)),
                const SizedBox(height: 4),
                Text(value, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
