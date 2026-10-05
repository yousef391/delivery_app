import 'package:flutter/material.dart';

class BookingActiveTripView extends StatelessWidget {
  final VoidCallback onFinishTrip;

  const BookingActiveTripView({
    super.key,
    required this.onFinishTrip,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Trip in progress',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: Theme.of(context).colorScheme.primary, size: 16),
                  const SizedBox(width: 4),
                  Text('12 min left', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        LinearProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: onFinishTrip,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text('Simulate Finish Trip', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
          ),
        ),
      ],
    );
  }
}
