import os, re

base_dir = r'c:\work_dev\personal\Riglni\oran_delivery\lib\features\home\presentation'
screen_path = os.path.join(base_dir, 'screens', 'home_screen.dart')
widgets_dir = os.path.join(base_dir, 'widgets')
os.makedirs(widgets_dir, exist_ok=True)

with open(screen_path, 'r', encoding='utf-8') as f:
    code = f.read()

# Create models.dart
models_code = '''import 'package:latlong2/latlong.dart';

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
'''
with open(os.path.join(widgets_dir, 'models.dart'), 'w', encoding='utf-8') as f:
    f.write(models_code)

# Remove models from home_screen
code = re.sub(r'class PlaceResult \{.*?\n\}\n', '', code, flags=re.DOTALL)
code = re.sub(r'enum BookingState \{.*?\}\n', '', code, flags=re.DOTALL)
code = re.sub(r'class DriverOffer \{.*?\n\}\n', '', code, flags=re.DOTALL)

# Function to extract and replace a class
def extract_class(class_name, new_name, file_name, imports, code_str):
    pattern = r'(class ' + class_name + r' .*?\n\}(?:\n\nclass ' + class_name + r'State .*?\n\})?)'
    match = re.search(pattern, code_str, flags=re.DOTALL)
    if match:
        class_code = match.group(1)
        class_code = class_code.replace(class_name, new_name)
        
        full_code = imports + '\n\n' + class_code + '\n'
        with open(os.path.join(widgets_dir, file_name), 'w', encoding='utf-8') as f:
            f.write(full_code)
            
        code_str = code_str.replace(match.group(1), '')
        code_str = code_str.replace(class_name, new_name)
    return code_str

common_imports = '''import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:dio/dio.dart';
import '../../../../core/constants/colors.dart';
import 'models.dart';'''

widgets = [
    ('_TopBar', 'TopBar', 'top_bar.dart'),
    ('_AppDrawer', 'AppDrawer', 'app_drawer.dart'),
    ('_InteractiveMap', 'InteractiveMap', 'interactive_map.dart'),
    ('_LocationSearchSheet', 'LocationSearchSheet', 'location_search_sheet.dart'),
    ('_VehicleOption', 'VehicleOption', 'vehicle_option.dart'),
    ('_DriverOfferCard', 'DriverOfferCard', 'driver_offer_card.dart'),
    ('_BookingBottomSheet', 'BookingBottomSheet', 'booking_bottom_sheet.dart'),
]

for old, new, fname in widgets:
    imports = common_imports
    if new == 'BookingBottomSheet':
        imports += "\nimport 'location_search_sheet.dart';\nimport 'vehicle_option.dart';\nimport 'driver_offer_card.dart';"
    code = extract_class(old, new, fname, imports, code)

imports_to_add = '''import '../widgets/models.dart';
import '../widgets/top_bar.dart';
import '../widgets/app_drawer.dart';
import '../widgets/interactive_map.dart';
import '../widgets/booking_bottom_sheet.dart';
'''
code = code.replace("import '../../../../core/constants/colors.dart';", "import '../../../../core/constants/colors.dart';\n" + imports_to_add)

# Clean up empty lines
code = re.sub(r'\n{3,}', '\n\n', code)

with open(screen_path, 'w', encoding='utf-8') as f:
    f.write(code)
