import 'package:latlong2/latlong.dart';

class PlaceResult {
  final String name;
  final LatLng location;
  PlaceResult({required this.name, required this.location});
}

enum BookingState { input, searching, offers, matched }

class DriverOffer {
  final String name;
  final double rating;
  final int distanceMin;
  final int priceDzd;
  
  DriverOffer(this.name, this.rating, this.distanceMin, this.priceDzd);
}
