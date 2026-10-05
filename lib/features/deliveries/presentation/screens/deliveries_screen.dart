import 'package:flutter/material.dart';

class DeliveriesScreen extends StatelessWidget {
  const DeliveriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
          'My Deliveries', 
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
          _buildDeliveryItem(context, 'Package delivery', 'Today, 10:30 AM', 'Delivered', Theme.of(context).colorScheme.primary, Icons.check_circle),
          _buildDeliveryItem(context, 'Food delivery', 'Yesterday, 2:15 PM', 'Delivered', Theme.of(context).colorScheme.primary, Icons.check_circle),
          _buildDeliveryItem(context, 'Keys', 'Oct 1, 9:00 AM', 'Canceled', Colors.redAccent, Icons.cancel),
        ],
      ),
    );
  }

  Widget _buildDeliveryItem(BuildContext context, String title, String date, String status, Color statusColor, IconData icon) {
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
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: statusColor, size: 28),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(date, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 14)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status, 
              style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
