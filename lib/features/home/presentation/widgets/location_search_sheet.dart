import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:dio/dio.dart';
import '../../../../core/constants/colors.dart';
import 'models.dart';

class LocationSearchSheet extends StatefulWidget {
  final String title;
  final Function(PlaceResult) onSelect;

  const LocationSearchSheet({required this.title, required this.onSelect});

  @override
  State<LocationSearchSheet> createState() => LocationSearchSheetState();
}

class LocationSearchSheetState extends State<LocationSearchSheet> {
  final TextEditingController _searchController = TextEditingController();
  final Dio _dio = Dio();
  List<PlaceResult> _results = [];
  bool _isLoading = false;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () {
      _searchLocations(query);
    });
  }

  void _searchLocations(String query) async {
    if (query.isEmpty) {
      setState(() {
        _results = [];
        _isLoading = false;
      });
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 100% Free OpenStreetMap Nominatim Geocoding API
      // Nominatim REQUIRES a User-Agent header, otherwise they block requests (403 Forbidden)
      final response = await _dio.get(
        'https://nominatim.openstreetmap.org/search',
        queryParameters: {
          'q': '$query, Oran, Algeria', // Focus results on Oran
          'format': 'json',
          'limit': 6,
        },
        options: Options(
          headers: {
            'User-Agent': 'OranDeliveryApp/1.0',
          },
        ),
      );

      final List data = response.data;
      setState(() {
        _results = data.map((json) {
          final displayName = json['display_name'] as String;
          // Clean up the massive OSM address string to something short
          final parts = displayName.split(',');
          final shortName = parts.take(2).join(',');

          return PlaceResult(
            name: shortName.trim(),
            location: LatLng(
              double.parse(json['lat']),
              double.parse(json['lon']),
            ),
          );
        }).toList();
      });
    } catch (e) {
      print('Search error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 48,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _searchController,
                autofocus: true,
                onChanged: _onSearchChanged,
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  hintText: 'Search streets, landmarks in Oran...',
                  hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (_isLoading)
                Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: _results.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(
                          Icons.location_on,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text(
                          _results[index].name,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Oran, Algeria',
                          style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                        ),
                        onTap: () => widget.onSelect(_results[index]),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
