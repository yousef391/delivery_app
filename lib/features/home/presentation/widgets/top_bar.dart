import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:dio/dio.dart';
import '../../../../core/constants/colors.dart';
import 'models.dart';

class TopBar extends StatelessWidget {
  const TopBar();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.menu, color: Theme.of(context).colorScheme.onSurface),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 10,
                  ),
                ],
                border: Border.all(color: Theme.of(context).cardColor, width: 2),
              ),
              child: CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/images/avatar.jpg'),
                backgroundColor: Theme.of(context).cardColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
