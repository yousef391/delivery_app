import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:dio/dio.dart';
import '../../../../core/constants/colors.dart';
import 'models.dart';

class InteractiveMap extends StatelessWidget {
  final MapController mapController;
  final PlaceResult? pickup;
  final PlaceResult? dropoff;
  final List<LatLng> routePoints;

  const InteractiveMap({
    required this.mapController,
    this.pickup,
    this.dropoff,
    required this.routePoints,
  });

  @override
  Widget build(BuildContext context) {
    const oranCenter = LatLng(35.6987, -0.6341);

    return FlutterMap(
      mapController: mapController,
      options: const MapOptions(initialCenter: oranCenter, initialZoom: 13.0),
      children: [
        // Free OpenStreetMap wrapped in a Color Filter to make it Dark Mode
        ColorFiltered(
          colorFilter: const ColorFilter.matrix([
            -1,
            0,
            0,
            0,
            255,
            0,
            -1,
            0,
            0,
            255,
            0,
            0,
            -1,
            0,
            255,
            0,
            0,
            0,
            1,
            0,
          ]),
          child: TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dz.oran.delivery',
          ),
        ),

        // Draw the Route Polyline
        if (routePoints.isNotEmpty)
          PolylineLayer(
            polylines: [
              Polyline(
                points: routePoints,
                color: Theme.of(context).colorScheme.primary,
                strokeWidth: 4.0,
              ),
            ],
          ),

        // Draw Location Pins
        MarkerLayer(
          markers: [
            if (pickup != null)
              Marker(
                point: pickup!.location,
                width: 50,
                height: 50,
                child: Icon(
                  Icons.location_on,
                  color: Theme.of(context).colorScheme.primary,
                  size: 40,
                ),
              ),
            if (dropoff != null)
              Marker(
                point: dropoff!.location,
                width: 50,
                height: 50,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 40,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
