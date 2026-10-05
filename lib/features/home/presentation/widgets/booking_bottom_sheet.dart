import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import 'models.dart';
import 'location_search_sheet.dart';
import 'booking/booking_input_view.dart';
import 'booking/booking_searching_view.dart';
import 'booking/booking_matched_view.dart';
import 'booking/booking_active_trip_view.dart';

enum BookingState {
  input,
  searching,
  matched,
  activeTrip,
}

class BookingBottomSheet extends StatefulWidget {
  final ScrollController scrollController;
  final String pickupName;
  final String dropoffName;
  final double distanceKm;
  final double durationMin;
  final Function(bool isPickup, PlaceResult place) onLocationsUpdated;

  const BookingBottomSheet({
    super.key,
    required this.scrollController,
    required this.pickupName,
    required this.dropoffName,
    required this.distanceKm,
    required this.durationMin,
    required this.onLocationsUpdated,
  });

  @override
  State<BookingBottomSheet> createState() => _BookingBottomSheetState();
}

class _BookingBottomSheetState extends State<BookingBottomSheet> {
  String _selectedVehicle = 'Moto';
  bool _isHeavyPackage = false;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _fareController = TextEditingController();
  
  BookingState _currentState = BookingState.input;
  Timer? _offerTimer;
  List<DriverOffer> _offers = [];
  DriverOffer? _acceptedOffer;

  @override
  void initState() {
    super.initState();
    _recalculateFare();
  }

  @override
  void didUpdateWidget(BookingBottomSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.distanceKm != oldWidget.distanceKm || widget.durationMin != oldWidget.durationMin) {
      _recalculateFare();
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _weightController.dispose();
    _fareController.dispose();
    _offerTimer?.cancel();
    super.dispose();
  }

  void _recalculateFare() {
    if (widget.distanceKm == 0) return;
    double baseFare = 200;
    double perKm = 50;
    if (_selectedVehicle == 'Car') {
      baseFare = 300;
      perKm = 80;
    } else if (_selectedVehicle == 'Camion') {
      baseFare = 1000;
      perKm = 150;
    }
    double total = baseFare + (widget.distanceKm * perKm);
    if (_isHeavyPackage) {
      total *= 1.5;
    }
    _fareController.text = total.round().toString();
  }

  void _startSearching() {
    setState(() {
      _currentState = BookingState.searching;
      _offers.clear();
    });
    int offerCount = 0;
    _offerTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted || _currentState != BookingState.searching) {
        timer.cancel();
        return;
      }
      setState(() {
        _offers.add(DriverOffer(
          offerCount % 2 == 0 ? 'Ahmed K.' : 'Karim B.',
          4.8 + (offerCount * 0.1) % 0.2,
          3 + offerCount,
          (double.parse(_fareController.text) * (0.9 + (offerCount * 0.05))).round(),
        ));
      });
      offerCount++;
      if (offerCount >= 3) {
        timer.cancel();
      }
    });
  }

  void _openLocationSearch(bool isPickup) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => LocationSearchSheet(
        title: isPickup ? 'Pick up location' : 'Where to?',
        onSelect: (place) {
          Navigator.pop(context);
          widget.onLocationsUpdated(isPickup, place);
        },
      ),
    );
  }

  Widget _buildLocationRow(IconData icon, Color iconColor, String title, String subtitle, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 12)),
                Text(subtitle, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 30,
            offset: Offset(0, -10),
          ),
        ],
      ),
      child: SingleChildScrollView(
        controller: widget.scrollController,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                if (_currentState == BookingState.input)
                  BookingInputView(
                    pickupName: widget.pickupName,
                    dropoffName: widget.dropoffName,
                    distanceKm: widget.distanceKm,
                    durationMin: widget.durationMin,
                    selectedVehicle: _selectedVehicle,
                    isHeavyPackage: _isHeavyPackage,
                    descriptionController: _descriptionController,
                    weightController: _weightController,
                    fareController: _fareController,
                    onPickupTap: () => _openLocationSearch(true),
                    onDropoffTap: () => _openLocationSearch(false),
                    onVehicleSelected: (val) {
                      setState(() => _selectedVehicle = val);
                      _recalculateFare();
                    },
                    onHeavyPackageToggled: (val) {
                      setState(() => _isHeavyPackage = val);
                      _recalculateFare();
                    },
                    onWeightChanged: () => _recalculateFare(),
                    onRequestCourier: _startSearching,
                    buildLocationRow: _buildLocationRow,
                  ),
                if (_currentState == BookingState.searching)
                  BookingSearchingView(
                    offers: _offers,
                    onCancel: () {
                      setState(() {
                        _currentState = BookingState.input;
                        _offers.clear();
                      });
                    },
                    onAcceptOffer: (offer) {
                      setState(() {
                        _acceptedOffer = offer;
                        _currentState = BookingState.matched;
                      });
                    },
                  ),
                if (_currentState == BookingState.matched && _acceptedOffer != null)
                  BookingMatchedView(
                    acceptedOffer: _acceptedOffer!,
                    onCancel: () {
                      setState(() {
                        _currentState = BookingState.input;
                        _acceptedOffer = null;
                      });
                    },
                    onStartTrip: () {
                      setState(() => _currentState = BookingState.activeTrip);
                    },
                  ),
                if (_currentState == BookingState.activeTrip)
                  BookingActiveTripView(
                    onFinishTrip: () {
                      setState(() {
                        _currentState = BookingState.input;
                        _acceptedOffer = null;
                        _offers.clear();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Trip Finished Successfully!'),
                          backgroundColor: Theme.of(context).colorScheme.primary,
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
