import 'package:flutter/material.dart';
import '../models.dart';
import '../driver_offer_card.dart';

class BookingSearchingView extends StatelessWidget {
  final List<DriverOffer> offers;
  final VoidCallback onCancel;
  final Function(DriverOffer) onAcceptOffer;

  const BookingSearchingView({
    super.key,
    required this.offers,
    required this.onCancel,
    required this.onAcceptOffer,
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
              'Finding drivers...',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            TextButton(
              onPressed: onCancel,
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (offers.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: Column(
                children: [
                  CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
                  const SizedBox(height: 16),
                  Text(
                    'Broadcasting your request to nearby drivers...',
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          )
        else ...[
          ...offers.map((offer) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: DriverOfferCard(
              offer: offer,
              onExpired: () {
                // To properly support rejecting in the stateless widget, we can pass an onRejectOffer callback
                // but for now this is just UI.
              },
              onAccepted: () => onAcceptOffer(offer),
            ),
          )),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ],
      ],
    );
  }
}
