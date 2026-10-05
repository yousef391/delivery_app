import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:dio/dio.dart';
import '../../../../core/constants/colors.dart';
import '../widgets/models.dart';
import '../widgets/top_bar.dart';
import '../widgets/app_drawer.dart';
import '../widgets/interactive_map.dart';
import '../widgets/booking_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PlaceResult? _pickupLocation;
  PlaceResult? _dropoffLocation;
  List<LatLng> _routePoints = [];
  double _distanceKm = 0.0;
  double _durationMin = 0.0;

  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    // Default pickup to Oran center
    _pickupLocation = PlaceResult(
      name: 'Current Location',
      location: const LatLng(35.6987, -0.6341),
    );
  }

  void _fetchRoute() async {
    if (_pickupLocation == null || _dropoffLocation == null) return;
    try {
      final dio = Dio();
      final p1 = _pickupLocation!.location;
      final p2 = _dropoffLocation!.location;
      // OSRM Routing API (Free, open-source routing)
      final url =
          'http://router.project-osrm.org/route/v1/driving/${p1.longitude},${p1.latitude};${p2.longitude},${p2.latitude}?overview=full&geometries=geojson';

      final response = await dio.get(url);
      final routes = response.data['routes'] as List;
      if (routes.isNotEmpty) {
        final coords = routes[0]['geometry']['coordinates'] as List;
        final distanceM = routes[0]['distance'];
        final durationS = routes[0]['duration'];

        setState(() {
          _distanceKm = distanceM / 1000.0;
          _durationMin = durationS / 60.0;
          _routePoints = coords.map((c) => LatLng(c[1], c[0])).toList();
        });

        // Auto-zoom the map to fit the route polyline!
        _mapController.fitCamera(
          CameraFit.bounds(
            bounds: LatLngBounds.fromPoints(_routePoints),
            padding: const EdgeInsets.only(
              top: 150,
              left: 40,
              right: 40,
              bottom: 450,
            ),
          ),
        );
      }
    } catch (e) {
      print('Routing error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          // 1. Interactive Background Map (Dark Mode)
          InteractiveMap(
            mapController: _mapController,
            pickup: _pickupLocation,
            dropoff: _dropoffLocation,
            routePoints: _routePoints,
          ),

          // 2. Floating Action/Top Bar
          const TopBar(),

          // 3. Draggable Bottom Sheet Booking Form
          DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.15,
            maxChildSize: 0.85,
            snap: true,
            builder: (BuildContext context, ScrollController scrollController) {
              return BookingBottomSheet(
                scrollController: scrollController,
                pickupName: _pickupLocation?.name ?? 'Tap to search...',
                dropoffName: _dropoffLocation?.name ?? 'Where to?',
                distanceKm: _distanceKm,
                durationMin: _durationMin,
                onLocationsUpdated: (isPickup, place) {
                  setState(() {
                    if (isPickup) {
                      _pickupLocation = place;
                    } else {
                      _dropoffLocation = place;
                    }
                    if (_pickupLocation != null && _dropoffLocation != null) {
                      _fetchRoute();
                    } else if (place != null) {
                      _mapController.move(place.location, 15.0);
                    }
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

