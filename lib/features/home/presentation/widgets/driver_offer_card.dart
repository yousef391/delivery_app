import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:dio/dio.dart';
import '../../../../core/constants/colors.dart';
import 'models.dart';

class DriverOfferCard extends StatefulWidget {
  final DriverOffer offer;
  final VoidCallback onExpired;
  final VoidCallback onAccepted;

  const DriverOfferCard({super.key, required this.offer, required this.onExpired, required this.onAccepted});

  @override
  State<DriverOfferCard> createState() => DriverOfferCardState();
}

class DriverOfferCardState extends State<DriverOfferCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // 15 second timer
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    );
    _controller.forward().then((_) {
      if (mounted) widget.onExpired();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/avatar.jpg'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.offer.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.star, color: Theme.of(context).colorScheme.primary, size: 14),
                          const SizedBox(width: 4),
                          Text('${widget.offer.rating}', style: const TextStyle(color: Colors.white70)),
                          const SizedBox(width: 12),
                          const Icon(Icons.timer, color: Colors.white54, size: 14),
                          const SizedBox(width: 4),
                          Text('${widget.offer.distanceMin} min', style: const TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${widget.offer.priceDzd} DZD', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w900, fontSize: 18)),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: widget.onAccepted,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        minimumSize: const Size(0, 32),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Accept', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return LinearProgressIndicator(
                value: 1.0 - _controller.value,
                backgroundColor: Colors.transparent,
                color: Theme.of(context).colorScheme.primary,
                minHeight: 4,
              );
            },
          ),
        ],
      ),
    );
  }
}
