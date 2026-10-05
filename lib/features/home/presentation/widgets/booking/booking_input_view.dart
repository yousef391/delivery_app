import 'package:flutter/material.dart';
import '../vehicle_option.dart';

class BookingInputView extends StatelessWidget {
  final String pickupName;
  final String dropoffName;
  final double distanceKm;
  final double durationMin;
  final String selectedVehicle;
  final bool isHeavyPackage;
  final TextEditingController descriptionController;
  final TextEditingController weightController;
  final TextEditingController fareController;
  final VoidCallback onPickupTap;
  final VoidCallback onDropoffTap;
  final Function(String) onVehicleSelected;
  final Function(bool) onHeavyPackageToggled;
  final VoidCallback onWeightChanged;
  final VoidCallback onRequestCourier;
  final Widget Function(IconData, Color, String, String, VoidCallback) buildLocationRow;

  const BookingInputView({
    super.key,
    required this.pickupName,
    required this.dropoffName,
    required this.distanceKm,
    required this.durationMin,
    required this.selectedVehicle,
    required this.isHeavyPackage,
    required this.descriptionController,
    required this.weightController,
    required this.fareController,
    required this.onPickupTap,
    required this.onDropoffTap,
    required this.onVehicleSelected,
    required this.onHeavyPackageToggled,
    required this.onWeightChanged,
    required this.onRequestCourier,
    required this.buildLocationRow,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Request Courier',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: Theme.of(context).colorScheme.onSurface,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white10),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              buildLocationRow(
                Icons.circle,
                Theme.of(context).colorScheme.primary,
                'Pick up location',
                pickupName,
                onPickupTap,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 11.0, top: 4, bottom: 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(width: 2, height: 24, color: Colors.white12),
                ),
              ),
              buildLocationRow(
                Icons.square,
                Colors.white,
                'Where to?',
                dropoffName,
                onDropoffTap,
              ),
            ],
          ),
        ),
        if (distanceKm > 0)
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.route, color: Theme.of(context).colorScheme.primary, size: 20),
                        const SizedBox(width: 8),
                        Text('${distanceKm.toStringAsFixed(1)} km', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.timer, color: Theme.of(context).colorScheme.primary, size: 20),
                        const SizedBox(width: 8),
                        Text('${durationMin.round()} min', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 28),
        Text(
          'What are you delivering?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: descriptionController,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          decoration: InputDecoration(
            hintText: 'e.g. Documents, Keys, Food...',
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
        const SizedBox(height: 28),
        Text(
          'Vehicle Type',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            VehicleOption(
              icon: Icons.two_wheeler,
              label: 'Moto',
              isSelected: selectedVehicle == 'Moto',
              onTap: () => onVehicleSelected('Moto'),
            ),
            VehicleOption(
              icon: Icons.directions_car,
              label: 'Car',
              isSelected: selectedVehicle == 'Car',
              onTap: () => onVehicleSelected('Car'),
            ),
            VehicleOption(
              icon: Icons.local_shipping,
              label: 'Camion',
              isSelected: selectedVehicle == 'Camion',
              onTap: () => onVehicleSelected('Camion'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SwitchListTile(
          title: Text(
            'Is the package heavier than 5kg?',
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
          ),
          value: isHeavyPackage,
          activeTrackColor: Theme.of(context).colorScheme.primary,
          contentPadding: EdgeInsets.zero,
          onChanged: onHeavyPackageToggled,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            if (isHeavyPackage) ...[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Weight', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: weightController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
                      onChanged: (_) => onWeightChanged(),
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'kg',
                        hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
            ],
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Offer your fare', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: fareController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'e.g. 1500',
                      hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                      suffixText: 'DZD',
                      suffixStyle: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: (distanceKm > 0 && fareController.text.isNotEmpty) ? onRequestCourier : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              disabledBackgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            child: const Text('Request Courier', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
          ),
        ),
      ],
    );
  }
}
